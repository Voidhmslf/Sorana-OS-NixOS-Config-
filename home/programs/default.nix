{ pkgs, lib, ... }:

let
  # Список всех ярлыков LSP, которые мы хотим скрыть. 
  # Мы просто берем все файлы, которые начинаются на in.lsp_plug.
  lsp_plugins_desktop_files = [
    "in.lsp_plug.lsp_plugins_ab_tester_x2_mono" "in.lsp_plug.lsp_plugins_ab_tester_x2_stereo"
    "in.lsp_plug.lsp_plugins_ab_tester_x4_mono" "in.lsp_plug.lsp_plugins_ab_tester_x4_stereo"
    "in.lsp_plug.lsp_plugins_ab_tester_x8_mono" "in.lsp_plug.lsp_plugins_ab_tester_x8_stereo"
    "in.lsp_plug.lsp_plugins_art_delay_mono" "in.lsp_plug.lsp_plugins_art_delay_stereo"
    "in.lsp_plug.lsp_plugins_autogain_mono" "in.lsp_plug.lsp_plugins_autogain_stereo"
    "in.lsp_plug.lsp_plugins_beat_breather_mono" "in.lsp_plug.lsp_plugins_beat_breather_stereo"
    "in.lsp_plug.lsp_plugins_chorus_mono" "in.lsp_plug.lsp_plugins_chorus_stereo"
    "in.lsp_plug.lsp_plugins_clipper_mono" "in.lsp_plug.lsp_plugins_clipper_stereo"
    "in.lsp_plug.lsp_plugins_comp_delay_mono" "in.lsp_plug.lsp_plugins_comp_delay_stereo"
    "in.lsp_plug.lsp_plugins_comp_delay_x2_stereo" "in.lsp_plug.lsp_plugins_compressor_lr"
    "in.lsp_plug.lsp_plugins_compressor_mono" "in.lsp_plug.lsp_plugins_compressor_ms"
    "in.lsp_plug.lsp_plugins_compressor_stereo" "in.lsp_plug.lsp_plugins_crossover_lr"
    "in.lsp_plug.lsp_plugins_crossover_mono" "in.lsp_plug.lsp_plugins_crossover_ms"
    "in.lsp_plug.lsp_plugins_crossover_stereo" "in.lsp_plug.lsp_plugins_dyna_processor_lr"
    "in.lsp_plug.lsp_plugins_dyna_processor_mono" "in.lsp_plug.lsp_plugins_dyna_processor_ms"
    "in.lsp_plug.lsp_plugins_dyna_processor_stereo" "in.lsp_plug.lsp_plugins_expander_lr"
    "in.lsp_plug.lsp_plugins_expander_mono" "in.lsp_plug.lsp_plugins_expander_ms"
    "in.lsp_plug.lsp_plugins_expander_stereo" "in.lsp_plug.lsp_plugins_filter_mono"
    "in.lsp_plug.lsp_plugins_filter_stereo" "in.lsp_plug.lsp_plugins_flanger_mono"
    "in.lsp_plug.lsp_plugins_flanger_stereo" "in.lsp_plug.lsp_plugins_gate_lr"
    "in.lsp_plug.lsp_plugins_gate_mono" "in.lsp_plug.lsp_plugins_gate_ms"
    "in.lsp_plug.lsp_plugins_gate_stereo" "in.lsp_plug.lsp_plugins_gott_compressor_lr"
    "in.lsp_plug.lsp_plugins_gott_compressor_mono" "in.lsp_plug.lsp_plugins_gott_compressor_ms"
    "in.lsp_plug.lsp_plugins_gott_compressor_stereo" "in.lsp_plug.lsp_plugins_graph_equalizer_x16_lr"
    "in.lsp_plug.lsp_plugins_graph_equalizer_x16_mono" "in.lsp_plug.lsp_plugins_graph_equalizer_x16_ms"
    "in.lsp_plug.lsp_plugins_graph_equalizer_x16_stereo" "in.lsp_plug.lsp_plugins_graph_equalizer_x32_lr"
    "in.lsp_plug.lsp_plugins_graph_equalizer_x32_mono" "in.lsp_plug.lsp_plugins_graph_equalizer_x32_ms"
    "in.lsp_plug.lsp_plugins_graph_equalizer_x32_stereo" "in.lsp_plug.lsp_plugins_impulse_responses_mono"
    "in.lsp_plug.lsp_plugins_impulse_responses_stereo" "in.lsp_plug.lsp_plugins_impulse_reverb_mono"
    "in.lsp_plug.lsp_plugins_impulse_reverb_stereo" "in.lsp_plug.lsp_plugins_latency_meter"
    "in.lsp_plug.lsp_plugins_latency_meter_mono" "in.lsp_plug.lsp_plugins_latency_meter_stereo"
    "in.lsp_plug.lsp_plugins_limiter_lr" "in.lsp_plug.lsp_plugins_limiter_mono"
    "in.lsp_plug.lsp_plugins_limiter_ms" "in.lsp_plug.lsp_plugins_limiter_stereo"
    "in.lsp_plug.lsp_plugins_loud_comp_mono" "in.lsp_plug.lsp_plugins_loud_comp_stereo"
    "in.lsp_plug.lsp_plugins_matcher_mono" "in.lsp_plug.lsp_plugins_matcher_stereo"
    "in.lsp_plug.lsp_plugins_mb_clipper_mono" "in.lsp_plug.lsp_plugins_mb_clipper_stereo"
    "in.lsp_plug.lsp_plugins_mb_compressor_lr" "in.lsp_plug.lsp_plugins_mb_compressor_mono"
    "in.lsp_plug.lsp_plugins_mb_compressor_ms" "in.lsp_plug.lsp_plugins_mb_compressor_stereo"
    "in.lsp_plug.lsp_plugins_mb_dyna_processor_lr" "in.lsp_plug.lsp_plugins_mb_dyna_processor_mono"
    "in.lsp_plug.lsp_plugins_mb_dyna_processor_ms" "in.lsp_plug.lsp_plugins_mb_dyna_processor_stereo"
    "in.lsp_plug.lsp_plugins_mb_expander_lr" "in.lsp_plug.lsp_plugins_mb_expander_mono"
    "in.lsp_plug.lsp_plugins_mb_expander_ms" "in.lsp_plug.lsp_plugins_mb_expander_stereo"
    "in.lsp_plug.lsp_plugins_mb_gate_lr" "in.lsp_plug.lsp_plugins_mb_gate_mono"
    "in.lsp_plug.lsp_plugins_mb_gate_ms" "in.lsp_plug.lsp_plugins_mb_gate_stereo"
    "in.lsp_plug.lsp_plugins_mb_limiter_mono" "in.lsp_plug.lsp_plugins_mb_limiter_stereo"
    "in.lsp_plug.lsp_plugins_mb_ringmod_sc_mono" "in.lsp_plug.lsp_plugins_mb_ringmod_sc_stereo"
    "in.lsp_plug.lsp_plugins_mixer_x16_mono" "in.lsp_plug.lsp_plugins_mixer_x16_stereo"
    "in.lsp_plug.lsp_plugins_mixer_x4_mono" "in.lsp_plug.lsp_plugins_mixer_x4_stereo"
    "in.lsp_plug.lsp_plugins_mixer_x8_mono" "in.lsp_plug.lsp_plugins_mixer_x8_stereo"
    "in.lsp_plug.lsp_plugins_multiband_compressor_lr" "in.lsp_plug.lsp_plugins_multiband_compressor_mono"
    "in.lsp_plug.lsp_plugins_multiband_compressor_ms" "in.lsp_plug.lsp_plugins_multiband_compressor_stereo"
    "in.lsp_plug.lsp_plugins_multiband_expander_lr" "in.lsp_plug.lsp_plugins_multiband_expander_mono"
    "in.lsp_plug.lsp_plugins_multiband_expander_ms" "in.lsp_plug.lsp_plugins_multiband_expander_stereo"
    "in.lsp_plug.lsp_plugins_multiband_gate_lr" "in.lsp_plug.lsp_plugins_multiband_gate_mono"
    "in.lsp_plug.lsp_plugins_multiband_gate_ms" "in.lsp_plug.lsp_plugins_multiband_gate_stereo"
    "in.lsp_plug.lsp_plugins_multiband_limiter_lr" "in.lsp_plug.lsp_plugins_multiband_limiter_mono"
    "in.lsp_plug.lsp_plugins_multiband_limiter_ms" "in.lsp_plug.lsp_plugins_multiband_limiter_stereo"
    "in.lsp_plug.lsp_plugins_multisampler_x12" "in.lsp_plug.lsp_plugins_multisampler_x12_do"
    "in.lsp_plug.lsp_plugins_multisampler_x24" "in.lsp_plug.lsp_plugins_multisampler_x24_do"
    "in.lsp_plug.lsp_plugins_multisampler_x48" "in.lsp_plug.lsp_plugins_multisampler_x48_do"
    "in.lsp_plug.lsp_plugins_noise_generator_x1" "in.lsp_plug.lsp_plugins_noise_generator_x2"
    "in.lsp_plug.lsp_plugins_noise_generator_x4" "in.lsp_plug.lsp_plugins_oscillator_mono"
    "in.lsp_plug.lsp_plugins_oscilloscope_x1" "in.lsp_plug.lsp_plugins_oscilloscope_x2"
    "in.lsp_plug.lsp_plugins_oscilloscope_x4" "in.lsp_plug.lsp_plugins_oscillosope_x1"
    "in.lsp_plug.lsp_plugins_oscillosope_x2" "in.lsp_plug.lsp_plugins_oscillosope_x4"
    "in.lsp_plug.lsp_plugins_oscillosope_x8" "in.lsp_plug.lsp_plugins_para_equalizer_x16_lr"
    "in.lsp_plug.lsp_plugins_para_equalizer_x16_mono" "in.lsp_plug.lsp_plugins_para_equalizer_x16_ms"
    "in.lsp_plug.lsp_plugins_para_equalizer_x16_stereo" "in.lsp_plug.lsp_plugins_para_equalizer_x32_lr"
    "in.lsp_plug.lsp_plugins_para_equalizer_x32_mono" "in.lsp_plug.lsp_plugins_para_equalizer_x32_ms"
    "in.lsp_plug.lsp_plugins_para_equalizer_x32_stereo" "in.lsp_plug.lsp_plugins_phase_detector"
    "in.lsp_plug.lsp_plugins_phaser_mono" "in.lsp_plug.lsp_plugins_phaser_stereo"
    "in.lsp_plug.lsp_plugins_profiler_mono" "in.lsp_plug.lsp_plugins_profiler_stereo"
    "in.lsp_plug.lsp_plugins_referencer_mono" "in.lsp_plug.lsp_plugins_referencer_stereo"
    "in.lsp_plug.lsp_plugins_return_mono" "in.lsp_plug.lsp_plugins_return_stereo"
    "in.lsp_plug.lsp_plugins_ringmod_sc_mono" "in.lsp_plug.lsp_plugins_ringmod_sc_stereo"
    "in.lsp_plug.lsp_plugins_room_builder_mono" "in.lsp_plug.lsp_plugins_room_builder_stereo"
    "in.lsp_plug.lsp_plugins_sampler_mono" "in.lsp_plug.lsp_plugins_sampler_stereo"
    "in.lsp_plug.lsp_plugins_sc_autogain_mono" "in.lsp_plug.lsp_plugins_sc_autogain_stereo"
    "in.lsp_plug.lsp_plugins_sc_compressor_lr" "in.lsp_plug.lsp_plugins_sc_compressor_mono"
    "in.lsp_plug.lsp_plugins_sc_compressor_ms" "in.lsp_plug.lsp_plugins_sc_compressor_stereo"
    "in.lsp_plug.lsp_plugins_sc_dyna_processor_lr" "in.lsp_plug.lsp_plugins_sc_dyna_processor_mono"
    "in.lsp_plug.lsp_plugins_sc_dyna_processor_ms" "in.lsp_plug.lsp_plugins_sc_dyna_processor_stereo"
    "in.lsp_plug.lsp_plugins_sc_expander_lr" "in.lsp_plug.lsp_plugins_sc_expander_mono"
    "in.lsp_plug.lsp_plugins_sc_expander_ms" "in.lsp_plug.lsp_plugins_sc_expander_stereo"
    "in.lsp_plug.lsp_plugins_sc_gate_lr" "in.lsp_plug.lsp_plugins_sc_gate_mono"
    "in.lsp_plug.lsp_plugins_sc_gate_ms" "in.lsp_plug.lsp_plugins_sc_gate_stereo"
    "in.lsp_plug.lsp_plugins_sc_gott_compressor_lr" "in.lsp_plug.lsp_plugins_sc_gott_compressor_mono"
    "in.lsp_plug.lsp_plugins_sc_gott_compressor_ms" "in.lsp_plug.lsp_plugins_sc_gott_compressor_stereo"
    "in.lsp_plug.lsp_plugins_sc_limiter_lr" "in.lsp_plug.lsp_plugins_sc_limiter_mono"
    "in.lsp_plug.lsp_plugins_sc_limiter_ms" "in.lsp_plug.lsp_plugins_sc_limiter_stereo"
    "in.lsp_plug.lsp_plugins_sc_matcher_mono" "in.lsp_plug.lsp_plugins_sc_matcher_stereo"
    "in.lsp_plug.lsp_plugins_sc_mb_compressor_lr" "in.lsp_plug.lsp_plugins_sc_mb_compressor_mono"
    "in.lsp_plug.lsp_plugins_sc_mb_compressor_ms" "in.lsp_plug.lsp_plugins_sc_mb_compressor_stereo"
    "in.lsp_plug.lsp_plugins_sc_mb_dyna_processor_lr" "in.lsp_plug.lsp_plugins_sc_mb_dyna_processor_mono"
    "in.lsp_plug.lsp_plugins_sc_mb_dyna_processor_ms" "in.lsp_plug.lsp_plugins_sc_mb_dyna_processor_stereo"
    "in.lsp_plug.lsp_plugins_sc_mb_expander_lr" "in.lsp_plug.lsp_plugins_sc_mb_expander_mono"
    "in.lsp_plug.lsp_plugins_sc_mb_expander_ms" "in.lsp_plug.lsp_plugins_sc_mb_expander_stereo"
    "in.lsp_plug.lsp_plugins_sc_mb_gate_lr" "in.lsp_plug.lsp_plugins_sc_mb_gate_mono"
    "in.lsp_plug.lsp_plugins_sc_mb_gate_ms" "in.lsp_plug.lsp_plugins_sc_mb_gate_stereo"
    "in.lsp_plug.lsp_plugins_sc_mb_limiter_mono" "in.lsp_plug.lsp_plugins_sc_mb_limiter_stereo"
    "in.lsp_plug.lsp_plugins_sc_multiband_compressor_lr" "in.lsp_plug.lsp_plugins_sc_multiband_compressor_mono"
    "in.lsp_plug.lsp_plugins_sc_multiband_compressor_ms" "in.lsp_plug.lsp_plugins_sc_multiband_compressor_stereo"
    "in.lsp_plug.lsp_plugins_sc_multiband_expander_lr" "in.lsp_plug.lsp_plugins_sc_multiband_expander_mono"
    "in.lsp_plug.lsp_plugins_sc_multiband_expander_ms" "in.lsp_plug.lsp_plugins_sc_multiband_expander_stereo"
    "in.lsp_plug.lsp_plugins_sc_multiband_gate_lr" "in.lsp_plug.lsp_plugins_sc_multiband_gate_mono"
    "in.lsp_plug.lsp_plugins_sc_multiband_gate_ms" "in.lsp_plug.lsp_plugins_sc_multiband_gate_stereo"
    "in.lsp_plug.lsp_plugins_sc_multiband_limiter_lr" "in.lsp_plug.lsp_plugins_sc_multiband_limiter_mono"
    "in.lsp_plug.lsp_plugins_sc_multiband_limiter_ms" "in.lsp_plug.lsp_plugins_sc_multiband_limiter_stereo"
    "in.lsp_plug.lsp_plugins_send_mono" "in.lsp_plug.lsp_plugins_send_stereo"
    "in.lsp_plug.lsp_plugins_slap_delay_mono" "in.lsp_plug.lsp_plugins_slap_delay_stereo"
    "in.lsp_plug.lsp_plugins_spectrum_analyzer_x12" "in.lsp_plug.lsp_plugins_spectrum_analyzer_x16"
    "in.lsp_plug.lsp_plugins_spectrum_analyzer_x1" "in.lsp_plug.lsp_plugins_spectrum_analyzer_x2"
    "in.lsp_plug.lsp_plugins_spectrum_analyzer_x4" "in.lsp_plug.lsp_plugins_spectrum_analyzer_x8"
    "in.lsp_plug.lsp_plugins_surge_filter_mono" "in.lsp_plug.lsp_plugins_surge_filter_stereo"
    "in.lsp_plug.lsp_plugins_trigger_midi_mono" "in.lsp_plug.lsp_plugins_trigger_midi_stereo"
    "in.lsp_plug.lsp_plugins_trigger_mono" "in.lsp_plug.lsp_plugins_trigger_stereo"
  ];
in
{
  imports = [
    ./easyeda
    ./firefox.nix
    ./vscode.nix
    ./zed.nix
    ./vesktop.nix
    ./teams.nix
  ];

  home.packages = with pkgs; [
    # Твои браузеры
    
    # Твои рабочие инструменты
    neovim
    gemini-cli
    siyuan
    logseq
    material-design-icons
    nodejs
    
    # Сетевые инструменты
    networkmanager         # Вернет nmtui
    networkmanagerapplet   # Графический апплет для трея (nm-applet)
    brightnessctl          # Утилита для управления яркостью
    
    # И любые другие программы, которые ты захочешь добавить в будущем
    telegram-desktop
    (pkgs.symlinkJoin {
      name = "spotify";
      paths = [ pkgs.spotify ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/spotify \
          --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland --disable-features=WaylandFractionalScaleV1"
      '';
    })
    vesktop
    kdePackages.kdenlive
    reaper
    audacity
    easyeffects
    lsp-plugins

    # Игровые инструменты для Battle.net
    lutris
    bottles
    wineWow64Packages.staging
  ];

  xdg.configFile."easyeffects/input/Advanced-Voice.json".source = ./easyeffects/input/Advanced-Voice.json;
  xdg.configFile."easyeffects/presets/Advanced-Voice.json".source = ./easyeffects/input/Advanced-Voice.json;

  # Скрываем ВСЕ ярлыки LSP-плагинов из меню
  xdg.desktopEntries = lib.genAttrs lsp_plugins_desktop_files (name: {
    inherit name;
    noDisplay = true;
    exec = ""; # Обязательное поле для корректного переопределения
    categories = [ "AudioVideo" "Audio" ];
  });

  home.file.".gemini/prompt.md".source = ./gemini/GEMINI.md;
}
