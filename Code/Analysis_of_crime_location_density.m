boundaryData = readtable('CommArea_fixed.csv');

crimeData = readtable('Crimes_2023.csv');

figure; 
g = geoaxes; 

% Call the drawBoundary function
drawBoundary(boundaryData, g);

% Plot the crime density
hold on
geodensityplot(g, crimeData.Latitude, crimeData.Longitude, 'Radius', 5000);
hold off;

formatSpec = "Created %s";
tNow = datestr(now);
dim = [.13, 0, .07, .07];
str = {sprintf(formatSpec, tNow)}; 
annotation('textbox', dim, 'String', str, 'FitBoxToText', 'on');

% Title for the plot
title(g, 'Community Area Boundaries and Crime Location Density');
saveas(gcf, 'Crime_location_density_with_boundaries.jpg');
function drawBoundary(boundaryData, g)
    for i = 1:height(boundaryData)
        hold on;
        current_geom = boundaryData.the_geom{i};
        location_str = extractBetween(current_geom, "(((", ")))");
        current_str = location_str{1};
        coords = strsplit(current_str, ',');

        % Initialize arrays for latitudes and longitudes
        lat = zeros(1, length(coords));
        lon = zeros(1, length(coords));

        for j = 1:length(coords)
            location_num = coords{j};
            location_cell = strsplit(strtrim(location_num), ' ');
            lat(j) = str2double(location_cell{2}); 
            lon(j) = str2double(location_cell{1});
        end

        geoplot(g, lat, lon, '--', 'LineWidth', 1); 
        num = boundaryData.AREA_NUMBE(i);

        text(mean(lat), mean(lon), num2str(num), 'HorizontalAlignment', 'center', 'Color', 'red', 'FontSize', 8);
    end
end