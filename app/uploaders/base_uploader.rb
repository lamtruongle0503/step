# frozen_string_literal: true

class BaseUploader < Shrine
  plugin :activerecord
  plugin :pretty_location
  plugin :instrumentation
  plugin :validation_helpers

  Attacher.validate do
    return unless validate_min_size 1, message: 'File empty'
  end

  def generate_location(_io, _context)
    upload_date = Time.current.to_i
    name        = super
    ['private', upload_date, name].compact.join('/')
  end

  class UploadedFile
    def download
      apps_dir = Rails.root.join('tmp', 'apps')
      Dir.mkdir(apps_dir, 0o775) unless Dir.exist?(apps_dir)

      posix_time = Time.current.strftime('%s%L').to_i
      file_path = "#{apps_dir}/#{File.basename(data['id'], '.*')}_#{posix_time}#{File.extname(data['id'])}"
      stream(file_path)
      File.open(file_path)
    end
  end
end
