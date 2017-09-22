function cb_led_select(varargin)
if nargin<1
    block = gcb;
else
    block = varargin{1};
end

gpios = find_system(block, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'MaskType', 'GPIO_PNT_Output');
if length(gpios) ~= 1
   return 
end

gpio = gpios{1};

color = get_param(block, 'led_color');
switch color
    case 'Red'
        set_param(gpio, 'pcrNum', '43');
    case 'Green'
        set_param(gpio, 'pcrNum', '44');
    case 'Blue'
        set_param(gpio, 'pcrNum', '45');
    case 'None'
        set_param(block, 'Name', sprintf('LED_COLOR_SELECT'));
        return;
    otherwise
        error('Unknown selected color %s', color)
end

set_param(block, 'Name', sprintf('LED_IO_%s', upper(color)));
