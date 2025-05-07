//
//  PhotoModel.swift
//  PlaceBook
//
//  Created by 김건우 on 1/14/25.
//

import Foundation

struct Item {
    var id: UUID = UUID()
    var title: String
    var image: String
    var description: String
    
    init(title: String,
         image: String,
         description: String) {
        self.title = title
        self.image = image
        self.description = description
    }
}

struct ApplicationData {
    let photos: [Item] = [
        .init(title: "Seychelles", image: "1", description: """
            Seychelles is a tropical paradise located in the Indian Ocean, known for its pristine beaches with powdery white sand and crystal-clear turquoise waters. 
            It’s a dream destination for honeymooners and beach lovers, offering a sense of tranquility and seclusion. 
            The archipelago consists of 115 islands, each boasting unique charm, from lush vegetation to exotic wildlife.
            Visitors can indulge in activities such as snorkeling, scuba diving, and sailing, exploring vibrant coral reefs teeming with marine life. 
            The islands are also home to several nature reserves and rare species like the giant Aldabra tortoise.
            Anse Lazio and Anse Source d’Argent are among the most famous beaches, often featured in travel magazines.
            Seychelles offers luxury resorts with world-class amenities as well as eco-friendly lodges for sustainable travel.
            Beyond its natural beauty, the local Creole cuisine and culture provide a rich and authentic experience.
            If you're seeking relaxation, adventure, or simply a breathtaking escape, Seychelles is a perfect choice.
        """),
        .init(title: "Königssee", image: "2", description: """
            Königssee is a stunning natural lake situated in Bavaria, Germany, and is often regarded as one of the most beautiful lakes in the country.
            Nestled amidst the towering Bavarian Alps, it offers a serene atmosphere and crystal-clear emerald waters.
            The lake is known for its mirror-like reflections of the surrounding mountains and forests, creating a picture-perfect setting.
            Visitors can take electric boat tours across the lake, ensuring the environment remains unspoiled.
            One of the highlights is the pilgrimage church of St. Bartholomä, a historical and architectural gem accessible only by boat.
            The area is a haven for hikers, with trails leading to spectacular viewpoints and hidden waterfalls.
            Königssee is also a popular destination for photography enthusiasts, offering breathtaking vistas year-round.
            During winter, the lake transforms into a snowy wonderland, making it a favorite among winter sports lovers.
            Whether you're seeking peace, adventure, or a connection with nature, Königssee offers an unforgettable experience.
        """),
        .init(title: "Zanzibar", image: "3", description: """
            Zanzibar, an enchanting island off the coast of Tanzania, is a tropical paradise brimming with cultural richness and natural beauty.
            It is renowned for its spice farms, producing world-famous cloves, nutmeg, and cinnamon, earning it the nickname "Spice Island."
            The island is dotted with idyllic beaches featuring soft white sand and crystal-clear waters, perfect for sunbathing and snorkeling.
            Stone Town, a UNESCO World Heritage Site, is a maze of narrow streets filled with history, culture, and vibrant local markets.
            Visitors can explore centuries-old architecture influenced by Arab, Persian, and European styles.
            For wildlife enthusiasts, the Jozani Forest is a must-visit, home to the rare red colobus monkey.
            Zanzibar also offers world-class diving and kite surfing opportunities, making it a haven for water sports lovers.
            The island’s unique Swahili culture, warm hospitality, and flavorful cuisine make every visit memorable.
            Whether you're looking for relaxation or adventure, Zanzibar provides an unforgettable escape.
        """),
        .init(title: "Serengeti", image: "4", description: """
            The Serengeti National Park in Tanzania is one of the world’s most iconic safari destinations, known for its vast plains and incredible wildlife.
            It is most famous for the Great Migration, where millions of wildebeests, zebras, and gazelles traverse the plains in search of fresh grazing.
            This natural spectacle attracts wildlife enthusiasts and photographers from around the globe.
            The Serengeti is home to the "Big Five" — lions, elephants, leopards, rhinos, and buffalo — offering unparalleled game viewing opportunities.
            Visitors can enjoy hot air balloon safaris, providing breathtaking views of the endless savannah at sunrise.
            The park also hosts a variety of luxury lodges and tented camps, allowing guests to experience the wilderness in comfort.
            Birdwatchers can delight in spotting over 500 species of birds, ranging from ostriches to colorful bee-eaters.
            The Serengeti is a living testament to the beauty and resilience of nature, offering a profound connection to the wild.
        """),
        .init(title: "Castle", image: "5", description: """
            This medieval castle stands as a symbol of history, mystery, and architectural brilliance, making it a must-visit landmark.
            Surrounded by rolling hills and lush greenery, the castle offers a picturesque setting for exploration.
            Visitors can wander through ancient halls and towers, imagining the lives of knights and nobles who once resided here.
            The castle features intricate stonework, grand banquet halls, and a sprawling courtyard that tell stories of its rich past.
            Many legends and tales of intrigue are associated with this castle, adding an air of enchantment for history buffs.
            Guided tours provide insights into the castle’s construction, defensive mechanisms, and historical significance.
            The site often hosts medieval festivals, bringing history to life with period costumes, music, and reenactments.
            From the castle's highest tower, visitors can enjoy panoramic views of the surrounding countryside, making it a perfect spot for photography.
        """),
        .init(title: "Kyiv", image: "6", description: """
            Kyiv, the capital of Ukraine, is a vibrant city rich in history, culture, and architectural wonders.
            Known for its golden-domed churches, such as St. Sophia's Cathedral, it offers a glimpse into centuries of Eastern European history.
            The city is also home to the Kyiv-Pechersk Lavra, a UNESCO World Heritage Site and a spiritual center for Orthodox Christianity.
            Visitors can stroll along Andriyivskyy Descent, a historic street filled with artisan shops, galleries, and cafes.
            Kyiv’s bustling markets, like Besarabsky Market, provide a taste of local flavors and culture.
            The city boasts numerous green spaces, including the sprawling Hydropark and Mariinsky Park, perfect for relaxation.
            At night, Kyiv comes alive with a vibrant nightlife scene, offering everything from traditional music venues to modern clubs.
            The combination of historical significance and contemporary energy makes Kyiv a city full of charm and contrasts.
        """),
        .init(title: "Munich", image: "7", description: """
            Munich, the capital of Bavaria in Germany, is a city that perfectly blends tradition with modernity.
            It is renowned for its beer gardens, iconic Oktoberfest celebrations, and world-class breweries.
            Visitors can explore historic landmarks like the Nymphenburg Palace and Marienplatz, the city’s central square.
            The English Garden, one of the largest urban parks in the world, offers a peaceful retreat with scenic walking trails.
            Munich is also a hub for art and culture, with museums like the Alte Pinakothek and Deutsches Museum attracting visitors.
            The city’s culinary scene offers everything from hearty Bavarian dishes to international cuisine.
            During winter, the Christmas markets fill the city with festive cheer, offering traditional crafts and warm mulled wine.
            Munich’s efficient public transport system makes it easy to explore its charming neighborhoods and surrounding attractions.
        """),
        .init(title: "Lake", image: "8", description: """
            This serene lake is a hidden gem, surrounded by lush forests and majestic mountains.
            Its crystal-clear waters reflect the surrounding landscape, creating a breathtaking natural tableau.
            Visitors can enjoy peaceful boat rides, kayaking, or simply relaxing on the shores.
            The lake is a haven for wildlife, with birds and fish thriving in its pristine environment.
            Nearby hiking trails lead to scenic viewpoints, offering panoramic vistas of the lake and its surroundings.
            During sunrise and sunset, the lake transforms into a palette of colors, providing stunning photo opportunities.
            Whether you're seeking adventure or tranquility, this lake offers an idyllic escape from the hustle and bustle of daily life.
        """)
    ]
}
var AppData = ApplicationData()
