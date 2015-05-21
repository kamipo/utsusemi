require 'cases/helper'

class SoftDeletionTest < ActiveRecord::TestCase

  class ::User < ActiveRecord::Base
    acts_as_utsusemi
    # alias :delete :destroy
  end

  class ::DeletedUser < ActiveRecord::Base
  end

  def setup
    @connection = ActiveRecord::Base.connection
  end

  def teardown
    @connection.execute("DELETE FROM users")
    @connection.execute("DELETE FROM deleted_users")
  end

  test "destroyed record moves deleted table" do
    user = User.create(name: "kamipo", email: "mail@kamipo.net")

    assert User.find_by(id: user.id)

    user.destroy

    assert_not User.find_by(id: user.id)
    assert DeletedUser.find_by(id: user.id)
    assert User.only_deleted.find_by(id: user.id)
  end
end
