# frozen_string_literal: true

class AnalysisController < ApplicationController

  before_action :authenticate_doctor

  include ProfileHelper

  def new
    @analysis = Analysis.new
    render
  end

  def create
    @analysis = Analysis.new(analysis_params)
    @analysis.save
    @selected_profile = [combine_fio(@analysis.profile), @analysis.profile_id] if @analysis.profile_id.present?
    # TODO: Add success message when profile is created
    # TODO: Erase @analysis when profile is created to prevent it from autofilling the form
    render 'new'
  end

  protected

  def authenticate_doctor
    redirect_to root_path unless current_profile&.doctor?
    true
  end

  def analysis_params
    params[:analysis].permit(:profile_id, :analysis, :received_at, :operation_required, :min_duration, :max_duration)
  end

end
