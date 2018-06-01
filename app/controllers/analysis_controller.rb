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
    create_operation_for @analysis if @analysis.operation_required? && @analysis.valid?
    @analysis.save

    if @analysis.persisted?
      flash[:success] = 'Analysis has been successfully created!'
      redirect_to new_analysis_path and return
    end

    @selected_profile = [combine_fio(@analysis.profile), @analysis.profile_id] if @analysis.profile_id.present?
    render 'new'
  end

  protected

  def create_operation_for(analysis)
    operation = Operation.new
    operation.analysis = analysis
    operation.save

    p operation
    p analysis
  end

  def authenticate_doctor
    redirect_to root_path unless current_profile&.doctor?
    true
  end

  def analysis_params
    params[:analysis].permit(:profile_id, :analysis, :received_at, :operation_required, :min_duration, :max_duration)
  end

end
