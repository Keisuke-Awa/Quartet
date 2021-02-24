module DeviseFlashHelper
  def bootstrap_alert(flash_type)
    case flash_type
    when "alert"
      "warning"
    when "notice"
      "success"
    when "error"
      "danger"
    end
  end
end