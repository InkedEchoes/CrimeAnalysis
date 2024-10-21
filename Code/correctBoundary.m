function correctBoundary(inputFilename)
    table = readtable(inputFilename);
    output_table = table([], :);

    for i = 1:height(table)
        current_geom = table.the_geom{i};
        location_str = extractBetween(current_geom, "(((", ")))");

        % convert it to str
        current_str = location_str{1};
        coords = strsplit(current_str, ',');

        valid_coords = {}; % store the correct corrds
        error_found = false;
        for j = 1:length(coords)
            coord = strtrim(coords{j});
            numbers = str2num(coord);
            
            if isempty(numbers) || length(numbers) ~= 2
                error_found = true;
                break; % Stop processing further coordinates
            else
                valid_coords{end+1} = coord; % Add coordinate
            end
        end

        if ~error_found && ~isempty(valid_coords)
            new_geom = ['MULTIPOLYGON (((', strjoin(valid_coords, ', '), ')))'];
            table.the_geom{i} = new_geom;
        end
        output_table = [output_table; table(i, :)];  
    end
    writetable(output_table, 'CommArea_fixed.csv');
end
