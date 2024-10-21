
% Load community area boundaries
comm_data = readtable('CommArea_fixed.csv');

school_data = readtable('Chicago_Public_Schools.csv', 'Delimiter', ',');
school_district = school_data.PoliceDistrict;
school_latitude = school_data.Latitude;
school_longtitude = school_data.Longitude;
school_size = 5*ones((size(school_longtitude,1)),1);
% Load police stations
police_stations = readtable('Police_Stations_20240710.csv');

% Create the figure and geoaxes
figure;
g = geoaxes;
geobasemap topographic;

% Plot community area boundaries
for i = 1:height(comm_data)
    hold on;
    current_geom = comm_data.the_geom{i};
    location_str = extractBetween(current_geom, "(((", ")))");
    current_str = location_str{1};
    coords = strsplit(current_str, ',');
    lat = zeros(1, length(coords));
    lon = zeros(1, length(coords));

    for j = 1:length(coords)
        location_num = coords{j};
        location_cell = strsplit(strtrim(location_num), ' ');
        lat(j) = str2double(location_cell{2});
        lon(j) = str2double(location_cell{1});
    end

    geoplot(g, lat, lon, '-.', 'LineWidth', 1);
    num = comm_data.AREA_NUMBE(i);
    text(mean(lat), mean(lon), num2str(num), 'HorizontalAlignment', 'center', 'Color', 'red', 'FontSize', 8);
end

% Plot police stations
policeLat = police_stations.LATITUDE;
policeLon = police_stations.LONGITUDE;
size_police = 50*ones((size(policeLon,1)),1);

geobasemap  topographic

geoscatter(g,school_latitude,school_longtitude,school_size,'filled');
hold on 
geoscatter(g, policeLat, policeLon, size_police,'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'b');

% Add a title
title('Geographic Distribution of Schools and Police Stations');

% Add timestamp annotation
formatSpec = "Created %s";
tNow = datestr(now);
dim = [.13, 0, .07, .07];
str = {sprintf(formatSpec, tNow)};
annotation('textbox', dim, 'String', str, 'FitBoxToText', 'on');
hold off
% Save the figure
saveas(gcf, 'Distribution_of_Schools_and_Police_Stations.jpg');
