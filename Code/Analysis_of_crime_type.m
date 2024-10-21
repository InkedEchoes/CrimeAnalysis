% Read the original data
original_data = readtable('Crimes_2013_to_2023.csv', 'Delimiter', ',');

% Extract the primary crime types
crimes = original_data{:, 6}; 
num = size(original_data, 1);

% Initialize the types cell array
types = {};
types_num = 1;
types{1, 1} = crimes{1, 1};

% Initialize the array for counting
count(1, 1) = 1;

% Loop through each crime and find unique types
for i = 2:num
    current_crime = crimes{i, 1};
    is_new_type = true;
    for j = 1:types_num
        if strcmp(current_crime, types{1, j}) == 1
            is_new_type = false;
            count(j, 1) = count(j, 1) + 1; % Update count
            break;
        end
    end
    if is_new_type
        types_num = types_num + 1;
        types{1, types_num} = current_crime;
        count(types_num, 1) = 1; % Initialize count for new type
    end   
end

% Sort counts and find the top 10
[count_sort, idx_sort] = sort(count, 'descend');
top_ten = count_sort(1:10);
other_data = sum(count_sort(11:end));
plot_data = zeros(11, 1);
plot_data(1:10, 1) = top_ten;
plot_data(11) = other_data;

% Find the top 10 crimes
plot_crime = cell(11, 1);
for i = 1:10
    plot_crime{i, 1} = types{idx_sort(i)};
end
plot_crime{11, 1} = 'OTHERS';

%begin plotting

% Plot the pie chart
%fig = figure('Position', [100, 100, 1000, 800]); % [left, bottom, width, height]
figure
pie(plot_data);
title('Distribution of Top 10 Crime Primary Types (2013-2023)');

% Adjust the legend
lgd = legend(plot_crime, 'Location', 'west');
lgd.FontSize = 5;  % Set font size to 6 or any other smaller size


%Remove the timestamp annotation if not needed
formatSpec = "Created %s";
tNow = datestr(now);
dim = [.13,0,.07,.07];
str = {sprintf(formatSpec, tNow)}; 
annotation('textbox',dim,'String',str,'FitBoxToText','on');

% Save figure as image
saveas(figure, 'Crime_type_pie.jpg');

