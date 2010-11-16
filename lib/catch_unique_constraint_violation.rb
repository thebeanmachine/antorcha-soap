module CatchUniqueConstraintViolation
  def create_or_update_with_catch_unique
    begin
      create_or_update_without_catch_unique
    rescue ActiveRecord::StatementInvalid => e
      if detect_sqlite_constraint_violation e
        errors.add :message_id, "het unieke nummer voor het bericht is al reeds in gebruik (in de database)"
      end
      false
    end
  end
  
private
  def detect_sqlite_constraint_violation e
    e.message =~ /column message_id is not unique/
  end
  
  def self.included mod
    mod.send :alias_method_chain, :create_or_update, :catch_unique
  end
end
