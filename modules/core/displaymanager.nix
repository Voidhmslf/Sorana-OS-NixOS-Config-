{ ... }:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = 3; # Fire animation
      default_user = "void";
      save = true;
      load = true;
      
      # Кастомизация внешнего вида
      title = "Welcome home, Void! <3";
      box_title = "SoranaOS";
      clear_password = true;
      margin = 2;
      input_len = 34;
      
      # Цвета (используем индексы из нашей новой палитры)
      fg = 7;          # Пепельно-розовый текст
      bg = 0;          # Глубокий индиго фон
      border_fg = 2;   # Изумрудные границы
      active_fg = 13;  # Розовый цвет для активных элементов
    };
  };
}
