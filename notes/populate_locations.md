# Goal:  Only "populate" areas / locations players are near (and ideally likely to visit)

## Find location(s)
- nearestLocation
- nearestLocations

## Location info
- size 
    - [x radius, y radius]
        - in meters
- importance
- type
    - string of location's class name
- text
- locationPosition
- in
    - is position inside location !!!
- inArea
- inAreaArray
- rectangular
    - true if rectangular, false if ellipse

## Military bases ?!? "Ruins" (castle, temple, ...)
- For a given area, count the number of "military" class items?

## Process
- For each helipad
    - place helicopter
    - place repair unit (damaged? low on repair resources?)
    - place fuel unit
    - place [cargo, medical, ???] <- optional
- For each time tick
    - For each playableUnit
        - Find the nearest location
        - Is it less than DISTANCE?
            - Note -- vary distance based on:
                - fog, night, player in Helicopter, player in vehicle, altitude of helicopter
            - If yes, has it already been populated? 
                - If no:
                    - Place vehicles
                        - "cars" near roads and buildings
                    - Place units (civilians, spooks, ...)
                    - Place "set pieces" (compositions of units, buildings, triggers, ...) 
