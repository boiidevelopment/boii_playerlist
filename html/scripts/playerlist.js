/*
     ____   ____ _____ _____   _   _____  ________      ________ _      ____  _____  __  __ ______ _   _ _______ 
    |  _ \ / __ \_   _|_   _| | | |  __ \|  ____\ \    / /  ____| |    / __ \|  __ \|  \/  |  ____| \ | |__   __|
    | |_) | |  | || |   | |   | | | |  | | |__   \ \  / /| |__  | |   | |  | | |__) | \  / | |__  |  \| |  | |   
    |  _ <| |  | || |   | |   | | | |  | |  __|   \ \/ / |  __| | |   | |  | |  ___/| |\/| |  __| | . ` |  | |   
    | |_) | |__| || |_ _| |_  | | | |__| | |____   \  /  | |____| |___| |__| | |    | |  | | |____| |\  |  | |   
    |____/ \____/_____|_____| | | |_____/|______|   \/   |______|______\____/|_|    |_|  |_|______|_| \_|  |_|   
                              | |                                                                                
                              |_|               PLAYER LIST
*/

class Playerlist {
    constructor() {
        this.players = [];
        this.roles = [
            { name: 'Police', id: 'police', count: 0, icon: 'fa-shield-halved' },
            { name: 'EMS', id: 'ems', count: 0, icon: 'fa-kit-medical' },
            { name: 'Fire', id: 'fire', count: 0, icon: 'fa-fire' },
            { name: 'Lawyer', id: 'lawyer', count: 0, icon: 'fa-gavel' },
            { name: 'Taxi', id: 'taxi', count: 0, icon: 'fa-car-side' },
            { name: 'Towing', id: 'towing', count: 0, icon: 'fa-car-burst' }
        ];
        $(document).ready(() => {
            $(document).keyup((e) => this.handle_exit(e));
        });
    }

    handle_exit(e) {
        if (e.key === "Escape" || e.key === "Backspace") {
            this.close();
        }
    }

    init(data) {
        this.players = data.players;
        this.sort_players_by_id();
        this.calculate_role_counts();
        this.build();
    }

    calculate_role_counts() {
        this.roles.forEach(role => {
            role.count = this.players.filter(player => player.job.id === role.id).length;
        });
    }

    sort_players_by_id() {
        this.players.sort((a, b) => a.id - b.id);
    }

    build() {
        let content = `
            <div class="playerlist_container" style="display: none;">
                <div class="playerlist_header">
                    <div class="playerlist_header_left">
                        <img src="images/logo.png" class="header_logo">
                        <div class="header_name">BOII Development</div>
                    </div>
                    <div class="playerlist_header_right">
                        <i class="fa-solid fa-user"></i> <span class="players_online_count">${this.players.length} Online</span>
                    </div>
                </div>
                <h3 style="font-weight: normal; margin-left: 5px; margin-bottom: 5px; color: #b4b4b4; font-size: 1.6vh;">Active Roles</h3>
                <div class="role_grid">
                    ${this.roles.map(role => `
                        <div class="role_entry">
                            <i class="fa-solid ${role.icon}"></i>
                            <div class="role_label">${role.name}</div>
                            <div class="role_count">${role.count}</div>
                        </div>
                    `).join('')}
                </div>
                <div class="player_list_bottom">
                    <h3 style="font-weight: normal; margin-left: 5px; margin-bottom: 5px; color: #b4b4b4; font-size: 1.6vh;">Player List</h3>
                    <ul id="player_list">
                        ${this.players.map(player => `
                            <li>
                                <div class="player_entry">
                                    <img src="${player.headshot || 'images/default_user.jpg'}" class="profile_pic">
                                    <div class="player_info">
                                        <span class="player_label">Name</span>
                                        <span class="player_value">${player.name}</span>
                                    </div>
                                    <div class="player_info">
                                        <span class="player_label">Role</span>
                                        <span class="player_value">${player.rank.charAt(0).toUpperCase() + player.rank.slice(1) || 'N/A'}</span>
                                    </div>
                                    <div class="player_info">
                                        <span class="player_label">Job</span>
                                        <span class="player_value">${player.job.label}</span>
                                    </div>
                                    <div class="player_info">
                                        <span class="player_label">Ping</span>
                                        <span class="player_value">${player.ping} ms</span>
                                    </div>
                                    <div class="player_info">
                                        <span class="player_label">ID</span>
                                        <span class="player_value">${player.id}</span>
                                    </div>
                                </div>
                            </li>
                        `).join('')}
                    </ul>
                </div>
                <h3 style="text-align: center; font-weight: normal; margin-left: 5px; margin-bottom: 5px; color: #b4b4b4; font-size: 1.6vh;">Press ESC or Backspace to close</h3>
            </div>
        `;
        $('#main_container').html(content);
        $('.playerlist_container').fadeIn(750);
    }

    close() {
        $('.playerlist_container').fadeOut(750);
        $.post(`https://${GetParentResourceName()}/close_player_list`, JSON.stringify({}));
    }
}

/*
// Usage example:
const test_player_list = new Playerlist();
const example_data = {
    players: [
        { name: 'John Doe', id: 1, job: { id: 'police', label: 'Police'}, ping: 50, role: 'Owner' },
        { name: 'Jane Smith', id: 2, job: { id: 'ems', label: 'EMS'}, ping: 30, role: 'Admin' },
    ]
}
test_player_list.init(example_data);
*/