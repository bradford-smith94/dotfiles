--[[
Clock Rings by Linux Mint (2011) reEdited by despot77

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
    lua_load ~/scripts/clock_rings.lua
    lua_draw_hook_pre clock_rings

Edited by Bradford Smith
updated: 7/27/2015
]]

settings_table = {
    {
        name='time',
        arg='%I.%M', --Hour
        max=12,
        bg_color=0x000000,
        bg_alpha=0.3,
        fg_color=0x1793D0,
        fg_alpha=0.6,
        x=65, y=65,
        radius=20,
        thickness=20,
        start_angle=0,
        end_angle=360
    },
    {
        name='time',
        arg='%M.%S', --Minute
        max=60,
        bg_color=0x000000,
        bg_alpha=0.3,
        fg_color=0x1793D0,
        fg_alpha=0.6,
        x=65, y=65,
        radius=45,
        thickness=15,
        start_angle=0,
        end_angle=360
    },
    {
        name='time',
        arg='%S', --Second
        max=60,
        bg_color=0x000000,
        bg_alpha=0.3,
        fg_color=0x1793D0,
        fg_alpha=0.6,
        x=65, y=65,
        radius=62,
        thickness=5,
        start_angle=0,
        end_angle=360
    },
    {
        name='cpu',
        arg='cpu1',
        max=100,
        bg_color=0x000000,
        bg_alpha=0.3,
        fg_color=0x1793D0,
        fg_alpha=0.8,
        x=50, y=250,
        radius=25,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
	{
        name='cpu',
        arg='cpu2',
        max=100,
        bg_color=0x000000,
        bg_alpha=0.3,
        fg_color=0x1793D0,
        fg_alpha=0.8,
        x=50, y=250,
        radius=20,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
	{
        name='cpu',
        arg='cpu3',
        max=100,
        bg_color=0x000000,
        bg_alpha=0.3,
        fg_color=0x1793D0,
        fg_alpha=0.8,
        x=50, y=250,
        radius=15,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
	{
        name='cpu',
        arg='cpu4',
        max=100,
        bg_color=0x000000,
        bg_alpha=0.3,
        fg_color=0x1793D0,
        fg_alpha=0.8,
        x=50, y=250,
        radius=10,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='memperc',
        arg='',
        max=100,
        bg_color=0x000000,
        bg_alpha=0.3,
        fg_color=0x1793D0,
        fg_alpha=0.8,
        x=75, y=300,
        radius=25,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='swapperc',
        arg='',
        max=100,
        bg_color=0x000000,
        bg_alpha=0.3,
        fg_color=0x1793D0,
        fg_alpha=0.8,
        x=75, y=300,
        radius=20,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='fs_used_perc',
        arg='/',
        max=100,
        bg_color=0x000000,
        bg_alpha=0.3,
        fg_color=0x1793D0,
        fg_alpha=0.8,
        x=100, y=350,
        radius=25,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
	{
        name='fs_used_perc',
        arg='/home',
        max=100,
        bg_color=0x000000,
        bg_alpha=0.3,
        fg_color=0x1793D0,
        fg_alpha=0.8,
        x=100, y=350,
        radius=20,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
	{
        name='fs_used_perc',
        arg='/boot',
        max=100,
        bg_color=0x000000,
        bg_alpha=0.3,
        fg_color=0x1793D0,
        fg_alpha=0.8,
        x=100, y=350,
        radius=15,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
}

-- Use these settings to define the origin and extent of your clock.

clock_r=65

-- "clock_x" and "clock_y" are the coordinates of the centre of the clock, in pixels, from the top left of the Conky window.

clock_x=100
clock_y=150

show_seconds=true

require 'cairo'

function rgb_to_r_g_b(color,alpha)
    return ((color / 0x10000) % 0x100) / 255., ((color / 0x100) % 0x100) / 255., (color % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
    local w,h=conky_window.width,conky_window.height

    local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
    local bgc, bga, fgc, fga=pt['bg_color'], pt['bg_alpha'], pt['fg_color'], pt['fg_alpha']

    local angle_0=sa*(2*math.pi/360)-math.pi/2
    local angle_f=ea*(2*math.pi/360)-math.pi/2
    local t_arc=t*(angle_f-angle_0)

    -- Draw background ring

    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
    cairo_set_line_width(cr,ring_w)
    cairo_stroke(cr)

    -- Draw indicator ring

    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
    cairo_stroke(cr)
end

function conky_clock_rings()
    local function setup_rings(cr,pt)
        local str=''
        local value=0

        str=string.format('${%s %s}',pt['name'],pt['arg'])
        str=conky_parse(str)

        value=tonumber(str)
        pct=value/pt['max']

        draw_ring(cr,pct,pt)
    end

    -- Check that Conky has been running for at least 5s

    if conky_window==nil then return end
    local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)

    local cr=cairo_create(cs)

    local updates=conky_parse('${updates}')
    update_num=tonumber(updates)

    if update_num>5 then
        for i in pairs(settings_table) do
            setup_rings(cr,settings_table[i])
        end
    end
end
