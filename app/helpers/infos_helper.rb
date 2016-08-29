module InfosHelper
  def clear_error(error)
    "Вы #{error.split('Вы').last}"
  end
end
