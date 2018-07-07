class Transfer
  attr_reader :sender, :receiver, :status, :amount
  
  def initialize(bank_account_from, bank_account_to, amount)
    @status   = "pending"
    @sender   = bank_account_from
    @receiver = bank_account_to
    @amount   = amount
  end

  def valid?
    return @sender.valid? && @receiver.valid? 
  end

  def execute_transaction
    if valid? && 
       @status != "complete" &&
       @sender.balance >= @amount
      @sender.withdraw(@amount)
      @receiver.deposit(@amount)
      @status = "complete"
    else
      reject_transfer
    end
  end

  def reverse_transfer
    if valid? && 
       @status == "complete" &&
       @receiver.balance >= @amount
      @receiver.withdraw(@amount)
      @sender.deposit(@amount)
      @status = "reversed"
    else
      reject_transfer
    end
  end

  def reject_transfer
    @status = "rejected"
    return "Transaction rejected. Please check your account balance."
  end

end
