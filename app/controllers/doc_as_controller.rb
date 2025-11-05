class DocAsController < ApplicationController
  before_action :set_doc_a, only: [:show, :edit, :update, :forward, :approve, :reject]
  
  def index
    @doc_as = DocA.where(user: current_user)
  end

  def show
  end

  def new
    @doc_a = DocA.new
    @next_eq_id = generate_next_eq_id
  end

  def create
    @doc_a = DocA.new(doc_a_params)
    @doc_a.user = current_user
    @doc_a.u_date = Time.current
    
    # Auto-generate Equipment ID
    if @doc_a.eq_id.blank?
      @doc_a.eq_id = generate_next_eq_id
    end

    if @doc_a.save
      @doc_a.update!(status: :pending_p_approval, u_date: Time.current)
      
      # Send email notification to approver P (non-blocking)
      begin
        ProcurementMailer.document_submitted_to_approver(@doc_a, 'P').deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
        # Continue even if email fails
      end
      
      redirect_to @doc_a, notice: 'Document A created successfully and forwarded to P'
    else
      @next_eq_id = generate_next_eq_id
      render :new
    end
  end

  def forward
    if @doc_a.update(remarks: params[:remarks], status: @doc_a.next_status)
      update_date_for_status(@doc_a.status)
      redirect_to dashboard_path, notice: "Document forwarded to next approver"
    else
      redirect_to @doc_a, alert: "Could not forward document"
    end
  end

  def approve
    remarks = params[:remarks]
    
    case current_user.user_name
    when 'P'
      @doc_a.update!(p_remarks: remarks, status: :pending_q_approval, p_date: Time.current)
      # Notify User U
      begin
        ProcurementMailer.document_approved_status(@doc_a, @doc_a.user, "Approved by P and forwarded to Q").deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
      # Notify next approver Q
      begin
        ProcurementMailer.document_submitted_to_approver(@doc_a, 'Q').deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
      redirect_to dashboard_path, notice: 'Document approved!'
    when 'Q'
      @doc_a.update!(q_remarks: remarks, status: :pending_r_approval, q_date: Time.current)
      # Notify User U
      begin
        ProcurementMailer.document_approved_status(@doc_a, @doc_a.user, "Approved by Q and forwarded to R").deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
      # Notify next approver R
      begin
        ProcurementMailer.document_submitted_to_approver(@doc_a, 'R').deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
      redirect_to dashboard_path, notice: 'Document approved!'
    when 'R'
      @doc_a.update!(r_remarks: remarks, status: :pending_s_approval, r_date: Time.current)
      # Notify User U
      begin
        ProcurementMailer.document_approved_status(@doc_a, @doc_a.user, "Approved by R and forwarded to S").deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
      # Notify next approver S
      begin
        ProcurementMailer.document_submitted_to_approver(@doc_a, 'S').deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
      redirect_to dashboard_path, notice: 'Document approved!'
    when 'S'
      @doc_a.update!(s_remarks: remarks, status: :approved, s_date: Time.current)
      
      # Notify User U
      begin
        ProcurementMailer.document_approved_status(@doc_a, @doc_a.user, "Fully Approved - Document A Complete").deliver_now
      rescue => e
        Rails.logger.error "Failed to send email: #{e.message}"
      end
      
      # Auto-create Doc B after S approves Doc A
      doc_b = AutoCreateDocBService.new(@doc_a, current_user).call
      if doc_b
        redirect_to new_doc_b_path(doc_a_id: @doc_a.id), notice: 'Document A approved! Please complete Document B.'
      else
        redirect_to dashboard_path, notice: 'Document A approved!'
      end
    else
      redirect_to dashboard_path, alert: 'You cannot approve this document'
    end
  end

  def reject
    rejection_reason = "#{current_user.user_name} rejected: #{params[:remarks]}"
    
    case current_user.user_name
    when 'P'
      @doc_a.update!(p_remarks: params[:remarks], status: :rejected, p_date: Time.current)
    when 'Q'
      @doc_a.update!(q_remarks: params[:remarks], status: :rejected, q_date: Time.current)
    when 'R'
      @doc_a.update!(r_remarks: params[:remarks], status: :rejected, r_date: Time.current)
    when 'S'
      @doc_a.update!(s_remarks: params[:remarks], status: :rejected, s_date: Time.current)
    end
    
    # Notify User U about rejection (non-blocking)
    begin
      ProcurementMailer.document_rejected_status(@doc_a, @doc_a.user, rejection_reason).deliver_now
    rescue => e
      Rails.logger.error "Failed to send email: #{e.message}"
    end
    
    redirect_to dashboard_path, notice: 'Document rejected!'
  end

  private

  def set_doc_a
    @doc_a = DocA.find(params[:id])
  end

  def doc_a_params
    params.require(:doc_a).permit(:name, :cost, :head, :u_remarks)
  end
  
  def generate_next_eq_id
    # Get all eq_ids that match the pattern CSE_\d+
    existing_ids = DocA.where("eq_id LIKE ?", "CSE_%").pluck(:eq_id)
    
    # Extract numeric parts and find the maximum
    max_num = existing_ids.map do |id|
      match = id.match(/CSE_(\d+)/)
      match ? match[1].to_i : 0
    end.max || 0
    
    # Return next ID
    "CSE_#{max_num + 1}"
  end

  def update_date_for_status(status)
    case status
    when 'pending_p_approval'
      @doc_a.update(u_date: Time.current) unless @doc_a.u_date
    when 'pending_q_approval'
      @doc_a.update(p_date: Time.current) unless @doc_a.p_date
    when 'pending_r_approval'
      @doc_a.update(q_date: Time.current) unless @doc_a.q_date
    when 'pending_s_approval'
      @doc_a.update(r_date: Time.current) unless @doc_a.r_date
    end
  end
end

