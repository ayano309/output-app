module PageList

  # 重複したscopeまとめる

  PER = 10

  def display_list(page)
    page(page).per(PER)
  end
end
