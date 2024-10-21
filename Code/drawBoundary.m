function drawBoundary(filename)
    data = readtable(filename);
    figure; % Open a new figure for plotting
        g = geoaxes; % Create geographic axes
    
    for i = 1:height(data)
        hold on;
        current_geom = data.the_geom{i};
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

        geoplot(g, lat, lon, 'k-', 'LineWidth', 2); 
        geobasemap streets
        num = data.AREA_NUMBE(i);

        text(mean(lat), mean(lon), num2str(num), 'HorizontalAlignment', 'center','Color', 'red', 'FontSize', 8);
    end
formatSpec = "Created %s";
tNow = datestr(now);
dim = [.13,0,.07,.07];
str = {sprintf(formatSpec, tNow)}; 
annotation('textbox',dim,'String',str,'FitBoxToText','on');
    hold off;
    
    title(g, 'Community Area Boundaries'); % 
    saveas(g,'Community_Area_Boundaries.jpg');
end
