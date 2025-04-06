gameplay _handler:
    type: world
    debug: false
    events:
        on player quits:
           - if <context.message.contains_text[<&e><player.name> left the game]>:
               - determine ""
        on player joins:
           - if <context.message.contains_text[<&e><player.name> joined the game]>:
               - determine "" 

gameplay2_handler:
    type: world
    debug: false
    events:
        on player breaks ancient_debris:
            - determine cancelled
        on player damages player:
            - stop if:!<player.inventory.contains_item[trident]>
            - itemcooldown TRIDENT d:15s
            - foreach <context.entity> as:__player:
                - stop if:!<player.inventory.contains_item[trident]>
                - itemcooldown TRIDENT d:15s
        after player death:
            - flag <player> ban:+:1
            - if <player.flag[ban]> == 5:
                - flag <player> ban:!
                - ban <player> expire:1h "reason:<&c>Kamu skill issue banget mati 5 kali , silakan tunggu 1 jam"
                - stop
        on player crafts respawn_anchor:
            - determine cancelled
        on player crafts end_crystal:
            - determine cancelled
        on player right clicks block with:respawn_anchor:
            - determine cancelled
        on player right clicks block with:end_crystal:
            - determine cancelled
        on player right clicks obsidian with:end_crystal:
            - determine cancelled
        on player right clicks respawn_anchor with:glowstone:
            - determine cancelled
        after player right clicks block with:ender_pearl:
            - ratelimit <player> 10s
            - stop if:!<player.inventory.contains_item[ender_pearl]>
            - wait 3t
            - itemcooldown ender_pearl d:10s

potion:
    type: world
    debug: false
    events:
        after player joins:
            - adjust <material[potion]> max_stack_size:12

Splash:
    type: world
    debug: false
    events:
        after player joins:
            - adjust <material[splash_potion]> max_stack_size:12

Totem:
    type: world 
    debug: false
    events:
    	after player joins:
            - adjust <material[totem_of_undying]> max_stack_size:6

totem_1:
    type: world
    debug: false
    events:
        on evoker dies:
            - define findtotew <context.drops.find_match[totem_of_undying]>
            - define no_totem <context.drops.remove[<[findtotew]>]>
            - determine <[no_totem]>

totem_2:
    type: world
    debug: false
    events:
        on evoker death:
            - if !<util.random_chance[0]>:
                - stop
            - else:
                - drop item totem_of_undying at <context.entity.location>

event_lisner:
    type: world
    events:
        on player chats:
            - determine passively cancelled
            - narrate "<dark_red><bold>ZYDAWN <white>/ Chat Disable"

geledahinven:
    type: world
    debug: false
    events:
        on player right clicks player:
        - if <player.is_sneaking>:
            - ratelimit <player> 1t
            - define yangklik <player>
            - define yangkliknama <player.name>
            - clickable until:30s save:yes:
                - narrate "<dark_red><bold>ZYDAWN <white>/ <&e><context.entity.name> <&f>Menerima Untuk Di Geledah!" targets:<[yangklik]>
                - narrate "<dark_red><bold>ZYDAWN <white>/ Kamu menerima untuk digeledah!" targets:<context.entity>
                - wait 2s
                - inventory open d:<context.entity.inventory> player:<[yangklik]>
            - clickable until:30s save:no:
                - narrate "<dark_red><bold>ZYDAWN <white>/ <context.entity.name> menolak untuk di geledah!" targets:<[yangklik]>
                - narrate "<dark_red><bold>ZYDAWN <white>/ Kamu menolak untuk digeledah!" targets:<context.entity>
            - narrate "<dark_red><bold>ZYDAWN <white>/ Kamu Ingin Di Geledah Apakah Kamu MengizinkanNya: <green><element[Iya].on_click[<entry[yes].command>]><white> / <red><element[Tidak].on_click[<entry[no].command>]> <gray><italic>(Click Tulisan Di Samping Ini)" targets:<context.entity>
            - narrate "<dark_red><bold>ZYDAWN <white>/ Berhasil Mengirim Permintaan Untuk Menggeledah" targets:<player>

mendingvillager_Listener:
    type: world
    debug: false
    events:
        on player right clicks villager:
            - define villager <context.entity>
            - define trades <[villager].trades>
            - foreach <[trades]> as:trade:
                - define n:++
                - define result <[trade].result>

                - if <[result].material.name> == enchanted_book:
                    - if <[result].enchantment_map.contains[mending]>:
                        - adjust <[villager]> trades:<[trades].exclude[<[trade]>]>

fishing_mending_handler:
    type: world
    debug: false
    events:
        on player fishes while caught_fish:
            - define random <util.random.int[1].to[10]>
            - define mending <context.item.is_enchanted>
            - if <[random]> < 6:
                - if <[mending]>:
                    - if <context.item.enchantment_map.contains[mending]>:
                        - determine caught:coal

config:
    type: data

    max stack golden apple: "12"
    max stack ender pearl: "6"
    max stack enchanted golden apple: "1"
    max stack cobweb: "1"
    max stack experience bottle: "35"

stack_golden_apple:
    type: world
    debug: false
    events:
        on player clicks golden_apple in inventory:
            - if <context.item.quantity> > <script[config].parsed_key[max stack golden apple]>:
                - adjust <material[golden_apple]> max_stack_size:<script[config].parsed_key[max stack golden apple]>
                - inventory update

stack_ender_pearl:
    type: world
    debug: false
    events:
        on player clicks ender_pearl in inventory:
            - if <context.item.quantity> > <script[config].parsed_key[max stack ender pearl]>:
                - adjust <material[ender_pearl]> max_stack_size:<script[config].parsed_key[max stack ender pearl]>
                - inventory update

stack_enchanted_golden_apple:
    type: world
    debug: false
    events:
        on player clicks enchanted_golden_apple in inventory:
            - if <context.item.quantity> > <script[config].parsed_key[max stack enchanted golden apple]>:
                - adjust <material[enchanted_golden_apple]> max_stack_size:<script[config].parsed_key[max stack enchanted golden apple]>
                - inventory update

stack_cobweb:
    type: world
    debug: false
    events:
        on player clicks cobweb in inventory:
            - if <context.item.quantity> > <script[config].parsed_key[max stack cobweb]>:
                - adjust <material[cobweb]> max_stack_size:<script[config].parsed_key[max stack cobweb]>
                - inventory update

stack_experience_bottle:
    type: world
    debug: false
    events:
        on player clicks experience_bottle in inventory:
            - if <context.item.quantity> > <script[config].parsed_key[max stack experience bottle]>:
                - adjust <material[experience_bottle]> max_stack_size:<script[config].parsed_key[max stack experience bottle]>
                - inventory update

totem_handler:
    type: world
    debug: false
    events:
        on player resurrected:
        - if <player.flag[daily_totem_uses]||0> >= 6:
            - determine cancelled
            - actionbar "<&c>You have reached your daily totem limit!"
            - playsound <player> sound:ENTITY_VILLAGER_NO
            - stop
        - flag <player> daily_totem_uses:++
        - wait 1t
        - heal <player> health:<player.health_max>
        - announce to_console "<player.name> used a totem. Daily uses: <player.flag[daily_totem_uses]>"
        - define remaining <element[5].sub[<player.flag[daily_totem_uses]>]>
        - actionbar "Totem used! <[remaining]> uses remaining today"

totem_reset:
    type: world
    debug: false
    events:
        on system time 00:00:
        - foreach <server.online_players> as:player:
            - flag <[player]> daily_totem_uses:!
        - announce to_console "Daily totem usage limits have been reset"

totemuses:
    type: command
    name: totemuses
    description: Check how many totem uses you have remaining today
    usage: /totemuses
    permission: totem.check
    script:
    - define uses <player.flag[daily_totem_uses]||0>
    - define remaining <element[5].sub[<[uses]>]>
    - narrate "You have used <[uses]> totems today (<[remaining]> remaining)"

resettotem:
    type: command
    name: resettotem
    description: Reset a player's totem usage count
    usage: /resettotem [player|all]
    permission: totem.admin
    tab completions:
        1: <server.online_players.parse[name].include[all]>
    script:
    - if !<context.args.is_empty>:
        - if <context.args.first> == all:
            - foreach <server.online_players> as:target:
                - flag <[target]> daily_totem_uses:!
                - narrate "Your totem usage count has been reset by <player.name>" targets:<[target]>
            - narrate "Reset totem usage count for all online players"
            - stop
        - define target <server.match_player[<context.args.first>]||null>
        - if <[target]> == null:
            - narrate "<&c>Player not found!"
            - stop
    - else:
        - define target <player>
    
    - flag <[target]> daily_totem_uses:!
    - narrate "Reset totem usage count for <[target].name>"
    - if <[target]> != <player>:
        - narrate "Your totem usage count has been reset by <player.name>" targets:<[target]>

hide_nametag_handler:
    type: world
    debug: false
    events:
        on player joins:
            - team name:<player.name> option:name_tag_visibility status:never add:<player>
            - stop