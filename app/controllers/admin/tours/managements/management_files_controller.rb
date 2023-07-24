# frozen_string_literal: true

class Admin::Tours::Managements::ManagementFilesController < ApiV1Controller
  def index
    management_files = Admin::TourOperations::ManagementOperations::ManagementFileOperations::Index.new(
      actor, params
    ).call
    render json: management_files,
           each_serializer: Admin::Tours::Managements::ManagementFiles::IndexSerializer, root: 'data'
  end
end
