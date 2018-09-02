class BookPolicy < ApplicationPolicy

  def delete?
   user.admin?
 end
end
