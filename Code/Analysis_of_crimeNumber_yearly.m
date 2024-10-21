fd = fopen('Crimes_2013_to_2023.csv', 'r');
original_data = readtable('Crimes_2013_to_2023.csv', 'Delimiter', ',');

crimes_count = zeros(1,11);
num = size(original_data, 1);

for j = 1:num
    current_date = original_data{j,3}; 
    % Assuming 'Date' column
    current_year = year(current_date); 
    % Extract the year from the datetime
    col = current_year - 2012;
    crimes_count(1,col) = crimes_count(1,col)+1;
end
fclose(fd);

figure;
years = 2013:1:2023;
fig = bar(years, crimes_count);

% set the title label and legend
title('Yearly Crime Number From 2013 to 2023','FontSize',14);
xlabel('Year','FontSize', 12);
ylabel('Yearly number of crimes', 'FontSize', 12);
legend({'Crime number'}, 'FontSize', 12);

%begin plotting
formatSpec = "Created %s";
tNow = datestr(now);
dim = [.13,0,.07,.07];
str = {sprintf(formatSpec, tNow)}; 
annotation('textbox',dim,'String',str,'FitBoxToText','on');

% save image
saveas(fig,'Yearly_crimeNumber_bar.jpg')