class ChangeRecordIdToStringInActiveStorageAttachments < ActiveRecord::Migration[7.0]
  def change
    change_column :active_storage_attachments, :record_id, :string
  end
end
