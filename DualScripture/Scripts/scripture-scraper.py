import requests
import json
from bs4 import BeautifulSoup

bom = [
    {
        'book': "1 Nephi",
        'chapters': 22,
        'url_code': "1-ne",
    },
    {
        'book': "2 Nephi",
        'chapters': 33,
        'url_code': "2-ne",
    },
    {
        'book': "Jacob",
        'chapters': 7,
        'url_code': "jacob",
    },
    {
        'book': "Enos",
        'chapters': 1,
        'url_code': "enos",
    },
    {
        'book': "Jarom",
        'chapters': 1,
        'url_code': "jarom",
    },
    {
        'book': "Omni",
        'chapters': 1,
        'url_code': "omni",
    },
    {
        'book': "Words of Mormon",
        'chapters': 1,
        'url_code': "w-of-m",
    },
    {
        'book': "Mosiah",
        'chapters': 29,
        'url_code': "mosiah",
    },
    {
        'book': "Alma",
        'chapters': 63,
        'url_code': "alma",
    },
    {
        'book': "Helaman",
        'chapters': 16,
        'url_code': "hel",
    },
    {
        'book': "3 Nephi",
        'chapters': 30,
        'url_code': "3-ne",
    },
    {
        'book': "4 Nephi",
        'chapters': 1,
        'url_code': "4-ne",
    },
    {
        'book': "Mormon",
        'chapters': 9,
        'url_code': "morm",
    },
    {
        'book': "Ether",
        'chapters': 15,
        'url_code': 'ether',
    },
    {
        'book': "Moroni",
        'chapters': 10,
        'url_code': 'moro',
    },
]

# "book": "1 Nephi",
#             "chapters": [
#                 {
#                     "chapter": 1,
#                     "reference": "1 Nephi 1",
#                     "verses": [
#                         {
#                             "reference": "1 Nephi 1:1",
#                             "text": "I, Nephi, having been born of goodly parents, therefore I was taught somewhat in all the learning of my father; and having seen many afflictions in the course of my days, nevertheless, having been highly favored of the Lord in all my days; yea, having had a great knowledge of the goodness and the mysteries of God, therefore I make a record of my proceedings in my days.",
#                             "verse": 1
#    
#                     },

def scrape_data():
    book_obj = {
        "books": []
    }

    for book in bom:
        book_name = book['book']
        book_url_code = book['url_code']
        total_chapters = book['chapters']

        # loop over bom array
        # loop over chapters range 1:total_chapters + 1
        # do the webscrape passing in the lds_slug and the chapter num
        # populate the chapter, reference and initiate the verses array
        # then use the input from the web scraper to get the verse data
        # once all done with the chapters, do all it again
        # get the chapter data
        chapters = []

        book_data = {
            "book": book_name,
            "chapters": [],
            "full_title": "TTTRRRRRRRRRRRRRRRRRRRTTTTASKFHKSHFKSDHFLSLKJFHSDKLJHF",
            "heading": "heading" ,
            "lds_slug": book_url_code,

        }
        for chapter_num in range(1, total_chapters + 1):
            chapter_data = {
                "chapter": chapter_num,
                "reference": f"{book_name} {chapter_num}",
                "verses": []
            }
            URL = f"https://www.churchofjesuschrist.org/study/scriptures/bofm/{book_url_code}/{chapter_num}?lang=ceb"
            page = requests.get(URL)

            soup = BeautifulSoup(page.content, "html.parser")
            scriptures = soup.find_all("p", class_="verse")
            
            verse_num = 1
            verse_data = []

            for verse in scriptures:
                text = " ".join(verse.text.strip().split(' ')[1:])
                verse_data.append({
                    "reference": f"{book_name} {chapter_num}:{verse_num}",
                    "text": text,
                    "verse": verse_num,
                })

                verse_num += 1

            chapter_data['verses'] = verse_data
            book_data['chapters'].append(chapter_data)
        
        book_obj["books"].append(book_data)

    json_data = json.dumps(book_obj, indent=4)

    file_path = "/Users/michaelknight/Documents/cebuano-bom.json"

    with open(file_path, 'w') as file:
        file.write(json_data)

def flatten_data():
    '''
         flatten the data to prepare it for moving left and right in the scriptures view
        should end up looking like this
        [
            {
                reference: '1 Nephi 3',
                verses: [
                   {
                            "reference": "1 Nephi 1:1",
                            "text": "Ako, si Nephi, tungod kay natawo sa matarong nga mga ginikanan, busa ako gitudloan sa tanan nga nakat-onan sa akong amahan; ug tungod kay nakakita sa daghan nga kasakit sa akong panahon, bisan pa niana, tungod kay ako gipangga gayod sa Ginoo sa tanan nakong panahon; oo, tungod kay ako adunay talagsaon nga kahibalo sa kaayo ug sa mga misteryo sa Dios, busa naghimo ako og talaan bahin sa akong gipanghimo sa akong panahon.",
                            "verse": 1
                        },
                        {
                            "reference": "1 Nephi 1:2",
                            "text": "Oo, ako naghimo og talaan pinaagi sa pinulongan sa akong amahan nga naglangkob sa kinaadman sa mga Judeo ug sa pinulongan sa mga Ehiptohanon.",
                            "verse": 2
                        }
                ] etc...
            }
        ]

        use this list, so that when the user clicks the left arrow button you just do verses = flat[index - 1]
        and right arrow you do verses = flat[index + 1]
        Should be the easiest way to do things!

        loop over the books in the json
            - loop over the chapters in each book
            - grab the reference, then add the verses to the verses prop for that reference
            - move on to the next one etc etc then save to a new 'flat-[language].json' file

            - do that for each language. 
    '''
    print('hello')
    pass


# scrape_data()

flatten_data()
# URL = f"https://www.churchofjesuschrist.org/study/scriptures/bofm/1-ne/1?lang=tgl"
# page = requests.get(URL)

# soup = BeautifulSoup(page.content, "html.parser")
# scriptures = soup.find_all("p", class_="verse")