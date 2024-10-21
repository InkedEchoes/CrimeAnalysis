% Load the data
data = readtable('Crimes_2023.csv');

latitude = data.Latitude;
longitude = data.Longitude;
districts = data.District;

% Remove rows with NaN values in latitude, longitude, or district
validRows = ~isnan(latitude) & ~isnan(longitude) & ~isnan(districts);
latitude = latitude(validRows);
longitude = longitude(validRows);
districts = districts(validRows);

max_district_num = max(districts); % count the number of districts
district_count = zeros(1, max_district_num);
district_latitude = zeros(1, max_district_num);
district_longitude = zeros(1, max_district_num);

for i = 1:length(districts)
    current_district = districts(i);
    current_latitude = latitude(i);
    current_longitude = longitude(i);
    district_count(current_district) = district_count(current_district) + 1;

    % Find the position for the districts
    district_latitude(current_district) = current_latitude;
    district_longitude(current_district) = current_longitude;
end

district_count_valid = [];
color_indices = [];
for i = 1:max_district_num
    if district_longitude(i) ~= 0
        district_count_valid = [district_count_valid, district_count(i)]; 
        color_indices = [color_indices, i];
    end
end

% Remove zeros from district_longitude and district_latitude
district_longitude = nonzeros(district_longitude);
district_latitude = nonzeros(district_latitude);

% Define the colormap
cmap1 = hot(23);

% Create the geobubble plot
figure
gb = geobubble(district_latitude, district_longitude, district_count_valid, categorical(color_indices));
geobasemap topographic 

% Set the title and the legend
gb.Title = 'Distribution of Crimes in Chicago Districts for 2023';
gb.SizeLegendTitle = 'Cases';
gb.ColorLegendTitle = 'District';
gb.LegendVisible = 'on';

% Set timebox
formatSpec = "Created %s";
tNow = datestr(now);
dim = [.13,0,.07,.07];
str = {sprintf(formatSpec, tNow)}; 
annotation('textbox',dim,'String',str,'FitBoxToText','on');

% Save the figure
saveas(gcf, 'Crime_distribution_bubble.jpg');
