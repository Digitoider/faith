# frozen_string_literal: true

class ProfileController < ApplicationController
  
  def index; end

  def paginate
    render json: get_profiles
  end

  private

  def get_profiles
    q = params[:q] || ''
    page = params[:page].to_i unless params[:page].blank?
    page = 1 if page.nil?
    per_page = 10
    offset = (page - 1) * per_page
    profiles = Profile.where('name LIKE :q OR surname LIKE :q OR middlename LIKE :q', q: "%#{q}%")
                      .offset(offset)
                      .limit(per_page)

    profiles = profiles.map do |p|
      fio = [p.name, p.surname, p.middlename].join ' '
      {text: fio, id: p.id}
    end

    {
      items: profiles,
      per_page: per_page,
      total_count: Profile.where('name LIKE :q OR surname LIKE :q OR middlename LIKE :q', q: "%#{q}%").count
    }
  end

end
