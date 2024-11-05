admins = {
    

    

    "focus@auth.meet.jitsi",
    "jvb@auth.meet.jitsi"
}

unlimited_jids = {
    "focus@auth.meet.jitsi",
    "jvb@auth.meet.jitsi"
}

plugin_paths = { "/prosody-plugins/", "/prosody-plugins-custom", "/prosody-plugins-contrib" }

muc_mapper_domain_base = "your-public-url.com";
muc_mapper_domain_prefix = "muc";

http_default_host = "your-public-url.com"









consider_bosh_secure = true;
consider_websocket_secure = true;


smacks_max_unacked_stanzas = 5;
smacks_hibernation_time = 60;
smacks_max_old_sessions = 1;




VirtualHost "localhost"

    authentication = "token"
    app_id = "your_app_id"  -- This should match the JWT_APP_ID from the .env
    app_secret = "your_jwt_secret"  -- This should match the JWT_APP_SECRET from the .env
    allow_empty_token = false  -- Only allow authenticated users
    enable_domain_verification = false
    ssl = {
        key = "/config/certs/localhost.key";
        certificate = "/config/certs/localhost.crt";
    }
    modules_enabled = {
        "bosh";
        
        "websocket";
        "smacks"; -- XEP-0198: Stream Management
        
        "speakerstats";
        "conference_duration";
        "room_metadata";
        
        "end_conference";
        
        
        
        "muc_lobby_rooms";
        
        
        "muc_breakout_rooms";
        
        
        "av_moderation";
        
        
        
        
        

    }

    main_muc = "muc.meet.jitsi"
    room_metadata_component = "metadata.your-public-url.com"
    
    lobby_muc = "lobby.your-public-url.com"
    
    

    

    
    breakout_rooms_muc = "breakout.your-public-url.com"
    

    speakerstats_component = "speakerstats.your-public-url.com"
    conference_duration_component = "conferenceduration.your-public-url.com"

    
    end_conference_component = "endconference.your-public-url.com"
    

    
    av_moderation_component = "avmoderation.your-public-url.com"
    

    c2s_require_encryption = true

    

    

VirtualHost "auth.meet.jitsi"
    ssl = {
        key = "/config/certs/auth.meet.jitsi.key";
        certificate = "/config/certs/auth.meet.jitsi.crt";
    }
    modules_enabled = {
        "limits_exception";
    }
    authentication = "internal_hashed"



Component "internal-muc.meet.jitsi" "muc"
    storage = "memory"
    modules_enabled = {
        "muc_hide_all";
        "muc_filter_access";
        }
    restrict_room_creation = true
    muc_filter_whitelist="auth.meet.jitsi"
    muc_room_locking = false
    muc_room_default_public_jids = true
    muc_room_cache_size = 1000
    muc_tombstones = false
    muc_room_allow_persistent = false

Component "muc.meet.jitsi" "muc"
    restrict_room_creation = true
    storage = "memory"
    modules_enabled = {
        "muc_meeting_id";
        
        "polls";
        "muc_domain_mapper";
        
        "muc_password_whitelist";
    }

    -- The size of the cache that saves state for IP addresses
    rate_limit_cache_size = 10000;

    muc_room_cache_size = 10000
    muc_room_locking = false
    muc_room_default_public_jids = true
    
    muc_password_whitelist = {
        "focus@auth.meet.jitsi";
    }
    muc_tombstones = false
    muc_room_allow_persistent = false

Component "focus.your-public-url.com" "client_proxy"
    target_address = "focus@auth.meet.jitsi"

Component "speakerstats.your-public-url.com" "speakerstats_component"
    muc_component = "muc.meet.jitsi"

Component "conferenceduration.your-public-url.com" "conference_duration_component"
    muc_component = "muc.meet.jitsi"


Component "endconference.your-public-url.com" "end_conference"
    muc_component = "muc.meet.jitsi"



Component "avmoderation.your-public-url.com" "av_moderation_component"
    muc_component = "muc.meet.jitsi"



Component "lobby.your-public-url.com" "muc"
    storage = "memory"
    restrict_room_creation = true
    muc_tombstones = false
    muc_room_allow_persistent = false
    muc_room_cache_size = 10000
    muc_room_locking = false
    muc_room_default_public_jids = true
    modules_enabled = {
        }

    


Component "breakout.your-public-url.com" "muc"
    storage = "memory"
    restrict_room_creation = true
    muc_room_cache_size = 10000
    muc_room_locking = false
    muc_room_default_public_jids = true
    muc_tombstones = false
    muc_room_allow_persistent = false
    modules_enabled = {
        "muc_meeting_id";
        "polls";
        }


Component "metadata.your-public-url.com" "room_metadata_component"
    muc_component = "muc.meet.jitsi"
    breakout_rooms_component = "breakout.your-public-url.com"



