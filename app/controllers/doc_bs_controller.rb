class DocBsController < ApplicationController
  before_action :set_doc_b, only: [:show, :edit, :update, :approve, :reject]
  
  def index
    @doc_bs = DocB.where(user: current_user)
  end

  def show
  end

  def new
    @doc_b = DocB.new
    
    if params[:doc_a_id]
      doc_a = DocA.find(params[:doc_a_id])
      @doc_b.eq_id = doc_a.eq_id
      @doc_b.name = doc_a.name
      @doc_b.cost = doc_a.cost
      @doc_b.head = doc_a.head
    else
      # Auto-generate equipment ID if not coming from Document A
      @next_eq_id = generate_next_eq_id
      @doc_b.eq_id = @next_eq_id
    end
  end

  def create
    @doc_b = DocB.new(doc_b_params)
    @doc_b.user = current_user
    @doc_b.u_date = Time.current
    
    # Auto-generate Equipment ID if blank
    if @doc_b.eq_id.blank?
      @doc_b.eq_id = generate_next_eq_id
    end

    if @doc_b.save
      @doc_b.update!(status: :pending_p_approval)
      
      # Send email notification to approver P (non-blocking)
      begin
        ProcurementMailer.document_submitted_to_approver(@doc_b, 'P').deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
      
      redirect_to @doc_b, notice: 'Document B created successfully and forwarded to P'
    else
      @next_eq_id = generate_next_eq_id
      render :new
    end
  end

  def approve
    remarks = params[:remarks]
    
    case current_user.user_name
    when 'P'
      @doc_b.update!(p_remarks: remarks, status: :pending_q_approval, p_date: Time.current)
      # Notify User U
      begin
        ProcurementMailer.document_approved_status(@doc_b, @doc_b.user, "Approved by P and forwarded to Q").deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
      # Notify next approver Q
      begin
        ProcurementMailer.document_submitted_to_approver(@doc_b, 'Q').deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
    when 'Q'
      @doc_b.update!(q_remarks: remarks, status: :pending_r_approval, q_date: Time.current)
      # Notify User U
      begin
        ProcurementMailer.document_approved_status(@doc_b, @doc_b.user, "Approved by Q and forwarded to R").deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
      # Notify next approver R
      begin
        ProcurementMailer.document_submitted_to_approver(@doc_b, 'R').deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
    when 'R'
      @doc_b.update!(r_remarks: remarks, status: :pending_s_approval, r_date: Time.current)
      # Notify User U
      begin
        ProcurementMailer.document_approved_status(@doc_b, @doc_b.user, "Approved by R and forwarded to S").deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
      # Notify next approver S
      begin
        ProcurementMailer.document_submitted_to_approver(@doc_b, 'S').deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
    when 'S'
      @doc_b.update!(s_remarks: remarks, status: :approved, s_date: Time.current)
      # Notify User U about final approval
      begin
        ProcurementMailer.document_approved_status(@doc_b, @doc_b.user, "Fully Approved - Document B Complete").deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
    end
    
    redirect_to dashboard_path, notice: 'Document approved!'
  end

  def reject
    rejection_reason = "#{current_user.user_name} rejected: #{params[:remarks]}"
    
    case current_user.user_name
    when 'P'
      @doc_b.update!(p_remarks: params[:remarks], status: :rejected, p_date: Time.current)
    when 'Q'
      @doc_b.update!(q_remarks: params[:remarks], status: :rejected, q_date: Time.current)
    when 'R'
      @doc_b.update!(r_remarks: params[:remarks], status: :rejected, r_date: Time.current)
    when 'S'
      @doc_b.update!(s_remarks: params[:remarks], status: :rejected, s_date: Time.current)
    end
    
    # Notify User U about rejection (non-blocking)
    begin
      ProcurementMailer.document_rejected_status(@doc_b, @doc_b.user, rejection_reason).deliver_now
    rescue => e
      Rails.logger.error "Failed to send email: #{e.message}"
    end
    
    redirect_to dashboard_path, notice: 'Document rejected!'
  end

  private

  def set_doc_b
    @doc_b = DocB.find(params[:id])
  end

  def doc_b_params
    params.require(:doc_b).permit(:name, :cost, :head, :proceedings, :u_remarks)
  end
  
  def generate_next_eq_id
    # Get all eq_ids that match the pattern CSE_\d+ from both DocA and DocB
    existing_ids_a = DocA.where("eq_id LIKE ?", "CSE_%").pluck(:eq_id)
    existing_ids_b = DocB.where("eq_id LIKE ?", "CSE_%").pluck(:eq_id)
    existing_ids = (existing_ids_a + existing_ids_b).uniq
    
    # Extract numeric parts and find the maximum
    max_num = existing_ids.map do |id|
      match = id.match(/CSE_(\d+)/)
      match ? match[1].to_i : 0
    end.max || 0
    
    # Return next ID
    "CSE_#{max_num + 1}"
  end
end

