module FileHelper

    def icon_for_mimetype(mime, extra_classes = "") 
      mimes = {
        'image': 'fa-file-image',
        'audio': 'fa-file-audio',
        'video': 'fa-file-video',
        # Documents
        'application/pdf': 'fa-file-pdf',
        'application/msword': 'fa-file-word',
        'application/vnd.ms-word': 'fa-file-word',
        'application/vnd.oasis.opendocument.text': 'fa-file-word',
        'application/vnd.openxmlformats-officedocument.wordprocessingml': 'fa-file-word',
        'application/vnd.ms-excel': 'fa-file-excel',
        'application/vnd.openxmlformats-officedocument.spreadsheetml': 'fa-file-excel',
        'application/vnd.oasis.opendocument.spreadsheet': 'fa-file-excel',
        'application/vnd.ms-powerpoint': 'fa-file-powerpoint',
        'application/vnd.openxmlformats-officedocument.presentationml': 'fa-file-powerpoint',
        'application/vnd.oasis.opendocument.presentation': 'fa-file-powerpoint',
        'text/plain': 'fa-file-text',
        'text/html': 'fa-file-code',
        'application/json': 'fa-file-code',
        # Archives
        'application/gzip': 'fa-file-archive',
        'application/zip': 'fa-file-archive',
      }.with_indifferent_access

      if mime
        m = mimes[mime.split('/').first]
        m ||= mimes[mime]
      end

      m ||= 'fa-file'

      "<i class='far #{extra_classes} #{m}'></i>".html_safe
    end

end