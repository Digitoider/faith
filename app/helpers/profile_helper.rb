module ProfileHelper
  def combine_fio(profile)
    [profile.surname, profile.name, profile.middlename].join ' '
  end
end
