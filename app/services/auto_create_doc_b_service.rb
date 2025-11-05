class AutoCreateDocBService
  def initialize(doc_a, user)
    @doc_a = doc_a
    @user = user
  end

  def call
    # Only create if Doc_B doesn't already exist for this eq_id
    unless DocB.exists?(eq_id: @doc_a.eq_id)
      DocB.create!(
        user: @user,
        eq_id: @doc_a.eq_id,
        name: @doc_a.name,
        cost: @doc_a.cost,
        head: @doc_a.head,
        proceedings: "Auto-generated after Document A approval",
        status: :draft,
        u_remarks: "Auto-initiated after Document A approval"
      )
    else
      DocB.find_by(eq_id: @doc_a.eq_id)
    end
  end
end

