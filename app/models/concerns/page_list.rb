module PageList

  # 重複したscopeまとめる

  PER = 2

  def display_list(page)
    page(page).per(PER)
  end
end
