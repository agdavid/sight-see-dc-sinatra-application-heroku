sight_list = {
    "Washington Monument" => {
      :description => "Towering tribute to George Washington"
    },
    "National Mall" => {
      :description => "Historical memorial parks on a promenade"
    },
    "United States Capitol" => {
      :description => "Legendary home of the U.S. legislature"
    },
    "White House" => {
      :description => "Iconic home of the U.S. president"
    },
    "Lincoln Memorial" => {
      :description => "Marble monument to the 16th U.S. president"
    },
    "National Zoological Park" => {
      :description => "Renowned, free zoo with giant pandas"
    },
    "National Museum of Natural History" => {
      :description => "Renowned collection of natural wonders, like dinosaur fossils"
    },
    "National Air and Space Museum" => {
      :description => "Exhibit-filled trip across the universe"
    },
    "Vietnam Veterans Memorial" => {
      :description => "Monument to U.S. service members during the Vietnam War"
    },
    "National World War II Memorial" => {
      :description => "Tribute to America's World War II efforts"
    },
    "United States Holocaust Memorial" => {
      :description => "Living remembrance of the Holocaust"
    },
    "Washington National Cathedral" => {
      :description => "Gothic-style Catholic church with music and views"
    },
    "John F. Kennedy Center for the Performing Arts" => {
      :description => "Renowned performing arts arena"
    },
    "National Portrait Gallery" => {
      :description => "Art depicting historic American figures"
    },
    "Verizon Center" => {
      :description => "Massive entertainment venue, home to the Wizards (NBA) and Capitols (NHL)"
    },
    "Nationals Park" => {
      :description => "Major League Basebal stadium, home to the Nationals (MLB)"
    }
  }

sight_list.each do |name, sight_hash|
  s = Sight.new
  s.name = name
  sight_hash.each do |attribute, value|
      s[attribute] = value
  end
  s.save
end