config_brutal_legend:
    type: data
    # if your world border is 5000..please use 2000
    rtp location: "2000"
    world border: "5000"
    rtp world name: "world"

join_flag_handler:
    type: world
    debug: false
    events:
        on player first login:
            - permission add denizen.clickable
            - flag <player> death:10
        on player joins:
            - if <player.has_flag[death]> = true:
                - stop
            - else:
                - flag <player> death:10   
                
random_teleport_on_spawn:
    type: world
    debug: false
    events:
        # random tp tfirst join
        after player login:
            - if <player.has_flag[join]>:
                - stop
            - else:
                - flag <player> join
                - define x <util.random.int[-<script[config_brutal_legend].parsed_key[rtp location]>].to[<script[config_brutal_legend].parsed_key[rtp location]>]>
                - define y <util.random.int[130].to[200]>
                - define z <util.random.int[-<script[config_brutal_legend].parsed_key[rtp location]>].to[<script[config_brutal_legend].parsed_key[rtp location]>]>
                - cast DAMAGE_RESISTANCE duration:20s amplifier:100 hide_particles no_icon no_ambient
                - teleport <player> <[x]>,<[y]>,<[z]>,<world[<script[config_brutal_legend].parsed_key[rtp world name]>]>             
        # random tp respawn no bed
        after player respawns:
            - if <player.bed_spawn.if_null[].equals[]>:
                - define x <util.random.int[-<script[config_brutal_legend].parsed_key[rtp location]>].to[<script[config_brutal_legend].parsed_key[rtp location]>]>
                - define y <util.random.int[130].to[200]>
                - define z <util.random.int[-<script[config_brutal_legend].parsed_key[rtp location]>].to[<script[config_brutal_legend].parsed_key[rtp location]>]>
                - cast DAMAGE_RESISTANCE duration:20s amplifier:100 hide_particles no_icon no_ambient
                - teleport <player> <[x]>,<[y]>,<[z]>,<world[<script[config_brutal_legend].parsed_key[rtp world name]>]>
            - else:
                - teleport <player> <player.bed_spawn>
                - stop