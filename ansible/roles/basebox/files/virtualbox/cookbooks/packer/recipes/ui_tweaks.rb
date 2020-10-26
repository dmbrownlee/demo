# show file extensions
registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' do
  values [{
    name: 'HideFileExt',
    type: :dword,
    data: 0,
  }]
end

# show hidden files
registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' do
  values [{
    name: 'Hidden',
    type: :dword,
    data: 1,
  }]
end

# launch explorer to the PC not the user
registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' do
  values [{
    name: 'LaunchTo',
    type: :dword,
    data: 1,
  }]
end

registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' do
  values [{
    name: 'FullPathAddress',
    type: :dword,
    data: 1,
  }]
end

# disable notification popups
registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' do
  values [{
    name: 'EnableBalloonTips',
    type: :dword,
    data: 0,
  }]
end

# disable error reporting popups
registry_key 'HKEY_CURRENT_USER\Software\Microsoft\Windows\Windows Error Reporting' do
  values [{
    name: 'DontShowUI',
    type: :dword,
    data: 0,
  }]
end
# disable prompting for a shutdown reason
registry_key 'HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Reliability' do
  values [{
    name: 'ShutdownReasonOn',
    type: :dword,
    data: 0,
  }]
end
# Set visual effects to best performance
registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' do
  values [{
    name: 'VisualFXSetting',
    type: :dword,
    data: 2,
  }]
end
# Don't use visual styles on windows and buttons
registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\ThemeManager' do
  values [{
    name: 'ThemeActive',
    type: :dword,
    data: 1,
  }]
end

registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\ThemeManager' do
  values [{
    name: 'ThemeActive',
    type: :dword,
    data: 1,
  }]
end

# Don't use common tasks in folders
registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' do
  values [{
    name: 'WebView',
    type: :dword,
    data: 0,
  }]
end

# Don't show translucent selection rectangle
registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' do
  values [{
    name: 'WebView',
    type: :dword,
    data: 0,
  }]
end

# Don't use drop shadows for icon labels on the desktop
registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' do
  values [{
    name: 'ListviewShadow',
    type: :dword,
    data: 0,
  }]
end

# Don't use a background image for each folder type
registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' do
  values [{
    name: 'ListviewWatermark',
    type: :dword,
    data: 0,
  }]
end

# Don't slide taskbar buttons
registry_key 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' do
  values [{
    name: 'TaskbarAnimations',
    type: :dword,
    data: 0,
  }]
end

# Don't animate windows when minimizing and maximizing
registry_key 'HKCU\Control Panel\Desktop\WindowMetrics' do
  values [{
    name: 'MinAnimate',
    type: :string,
    data: 0,
  }]
end

# Don't show window contents while dragging
registry_key 'HKCU\Control Panel\Desktop' do
  values [{
    name: 'DragFullWindows',
    type: :string,
    data: 0,
  }]
end

# Don't Smooth edges of screen fonts
registry_key 'HKCU\Control Panel\Desktop' do
  values [{
    name: 'FontSmoothing',
    type: :string,
    data: 0,
  }]
end

# Don't smooth scroll list boxes
# Don't slide open combo boxes
# Don't fade or slide menus into view
# Don't show shadows under mouse pointer
# Don't fade or slide tooltips into view
# Don't fade out menu items after clicking
# Don't show shadows under menus
registry_key 'HKCU\Control Panel\Desktop' do
  values [{
    name: 'UserPreferencesMask',
    type: :binary,
    data: '90,12,01,80',
  }]
end
