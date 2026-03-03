// 🦊 SoranaOS - AGS PowerMenu Ritual 💠
const resource = (name) => `resource:///com/github/Aylur/ags/${name}.js`;

const App = await import(resource('app')).then(m => m.default);
const Widget = await import(resource('widget')).then(m => m.default);
const { execAsync } = await import(resource('utils'));

const PowerButton = (label, icon, command) => Widget.Button({
    className: 'power-button',
    onClicked: () => {
        App.closeWindow('powermenu');
        execAsync(command);
    },
    child: Widget.Box({
        vertical: true,
        hpack: 'center',
        vpack: 'center',
        children: [
            Widget.Label({
                className: 'icon',
                label: icon,
            }),
            Widget.Label({
                className: 'label',
                label: label,
            }),
        ],
    }),
});

const PowerMenu = () => Widget.Box({
    className: 'powermenu-container',
    hpack: 'center',
    vpack: 'center',
    spacing: 20,
    children: [
        PowerButton('Lock', '󰌾', 'hyprlock'),
        PowerButton('Logout', '󰍃', 'hyprctl dispatch exit'),
        PowerButton('Suspend', '󰒲', 'systemctl suspend'),
        PowerButton('Hibernate', '󰒲', 'systemctl hibernate'),
        PowerButton('Reboot', '󰜉', 'systemctl reboot'),
        PowerButton('Shutdown', '󰐥', 'systemctl poweroff'),
    ],
});

const PowermenuWindow = Widget.Window({
    name: 'powermenu',
    className: 'powermenu-window',
    anchor: ['top', 'bottom', 'left', 'right'],
    exclusivity: 'ignore',
    keymode: 'exclusive',
    layer: 'overlay',
    visible: false,
    child: Widget.Box({
        className: 'overlay',
        hpack: 'center',
        vpack: 'center',
        css: 'min-width: 1920px; min-height: 1080px;',
        child: PowerMenu(),
    }),
});

// Добавляем бинд для Escape отдельно
PowermenuWindow.keybind('Escape', () => App.closeWindow('powermenu'));

App.config({
    style: App.configDir + '/style.css',
    windows: [
        PowermenuWindow,
    ],
});
