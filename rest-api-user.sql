create user web_data_viz_api identified by 'sptech';
grant insert, select, update, delete on composteco.* to web_data_viz_api;
flush privileges;