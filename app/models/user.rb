class User < ApplicationRecord
  has_attached_file :avatar, styles: { :medium => "300x300", :thumb => "100x100" }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  after_create :queue_welcome_email

  # def photo_data=(photo_data)
  #   self.data      = photo_data.read
  #   self.filename  = photo_data.original_filename
  #   self.mime_type = photo_data.content_type
  # end

  private

    # def send_welcome
    #   UserMailer.welcome(self).deliver
    # end

    def queue_welcome_email
      UserMailer.delay(run_at: 10.seconds.from_now).welcome( self.id )
    end
end
