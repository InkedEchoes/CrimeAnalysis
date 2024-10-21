fd = fopen('Crimes_2013_to_2023.csv', 'r');
original_data = readtable('Crimes_2013_to_2023.csv', 'Delimiter', ',');

fclose(fd);
original_data.Date = datetime(original_data.Date, 'InputFormat', 'yyyy-MM-dd');
original_data.Year = year(original_data.Date);
original_data.Month = month(original_data.Date);

crimes_count = zeros(12, 11); 

% calculate the number in one month
for i = 1:size(original_data, 1)
    current_year = original_data.Year(i);
    current_month = original_data.Month(i);
    year_index = current_year - 2012;
    month_index = current_month;
    crimes_count(month_index, year_index) = crimes_count(month_index, year_index) + 1;
end

% calculate the average
avg_crimes_count = mean(crimes_count, 2);

% plot
figure;
months = 1:12;
plot(months, avg_crimes_count, '-o', 'LineWidth', 2);
xlabel('Month', 'FontSize', 12);
ylabel('Average Accumulated Crime Count', 'FontSize', 12);
title('Average Accumulated Crime Cases by Month (2013-2023)', 'FontSize', 14);
grid on;

% set the label for the x-axis
xticks(months);
xticklabels({'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
legend({'Accumulated Crime number'}, 'FontSize', 12);

% add comment before plotting
formatSpec = "Created %s";
tNow = datestr(now);
dim = [.13, 0, .07, .07];
str = {sprintf(formatSpec, tNow)}; 
annotation('textbox', dim, 'String', str, 'FitBoxToText', 'on');

% save the figure
saveas(gcf, 'Accumulated_crimeNumber_line.jpg');
