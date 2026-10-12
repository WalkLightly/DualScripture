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
    did this update there too?
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

# flatten_data()
# URL = f"https://www.churchofjesuschrist.org/study/scriptures/bofm/1-ne/1?lang=tgl"
# page = requests.get(URL)

# soup = BeautifulSoup(page.content, "html.parser")
# scriptures = soup.find_all("p", class_="verse")

# eng



talk_data = { "October-2026": [] }

# talks-oct-2026 = [
#     {
#     "1": [
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/12gong?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/13runia?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/14causse?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/15sikahema?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/16hathaway?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/17soares?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/18douglas?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/19christofferson?lang="
#       ]},
#       {
#     "2": [
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/21renlund?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/22farnes?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/23chigbundu?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/24giuffra?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/25morgan?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/26fale?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/27kearon?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/28dunn?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/29eyring?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/210rasband?lang="
#       ]
#       },
#   {
#       "3": [
#     "https://www.churchofjesuschrist.org/study/general-conference/2026/10/41eyring?lang=",
#     "https://www.churchofjesuschrist.org/study/general-conference/2026/10/42chibota?lang=",
#     "https://www.churchofjesuschrist.org/study/general-conference/2026/10/43andersen?lang=",
#     "https://www.churchofjesuschrist.org/study/general-conference/2026/10/44fantone?lang=",
#     "https://www.churchofjesuschrist.org/study/general-conference/2026/10/45dube?lang=",
#     "https://www.churchofjesuschrist.org/study/general-conference/2026/10/46cook?lang=",
#     "https://www.churchofjesuschrist.org/study/general-conference/2026/10/47kyungu?lang=",
#     "https://www.churchofjesuschrist.org/study/general-conference/2026/10/48schmeil?lang=",
#     "https://www.churchofjesuschrist.org/study/general-conference/2026/10/49oaks?lang="
#         ]
#   },
#     {
#       "4": [
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/51uchtdorf?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/52munoz-spannaus?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/53villanueva?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/54bednar?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/55lebethoa?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/56sinclair?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/57stevenson?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/58reid?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/59gilbert?lang=",
#         "https://www.churchofjesuschrist.org/study/general-conference/2026/10/510oaks?lang="
#         ]
#     },
#  ]
# for general conference, AT LEAST THIS TIME
# talk title is the h1 of the <header> component
# class="author-name
# class="author-role"
#
# class="kicker
#
# for the talk content, it's the <p> tags in the class="body-block"
#
#
# talk_data = {
#     "October-2026": 
#         [
#             {
#                 "title": "",
#                 "author": "",
#                 "calling": "",
#                 "paragraphs": [""]
#             }
#         ]
#     }
# eng
talks = [
    {
    "1": [
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/12gong?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/13runia?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/14causse?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/15sikahema?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/16hathaway?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/17soares?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/18douglas?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/19christofferson?lang="
      ]},
      {
    "2": [
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/21renlund?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/22farnes?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/23chigbundu?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/24giuffra?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/25morgan?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/26fale?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/27kearon?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/28dunn?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/29eyring?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/210rasband?lang="
      ]
      },
  {
      "3": [
    "https://www.churchofjesuschrist.org/study/general-conference/2026/10/41eyring?lang=",
    "https://www.churchofjesuschrist.org/study/general-conference/2026/10/42chibota?lang=",
    "https://www.churchofjesuschrist.org/study/general-conference/2026/10/43andersen?lang=",
    "https://www.churchofjesuschrist.org/study/general-conference/2026/10/44fantone?lang=",
    "https://www.churchofjesuschrist.org/study/general-conference/2026/10/45dube?lang=",
    "https://www.churchofjesuschrist.org/study/general-conference/2026/10/46cook?lang=",
    "https://www.churchofjesuschrist.org/study/general-conference/2026/10/47kyungu?lang=",
    "https://www.churchofjesuschrist.org/study/general-conference/2026/10/48schmeil?lang=",
    "https://www.churchofjesuschrist.org/study/general-conference/2026/10/49oaks?lang="
        ]
  },
    {
      "4": [
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/51uchtdorf?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/52munoz-spannaus?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/53villanueva?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/54bednar?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/55lebethoa?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/56sinclair?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/57stevenson?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/58reid?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/59gilbert?lang=",
        "https://www.churchofjesuschrist.org/study/general-conference/2026/10/510oaks?lang="
        ]
    },
 ]
def scrape_conference_talks():
    #langCode = "eng"
    #langCode = "tgl"
    #langCode = "spa"
    langCode = "ceb"

    for item in talks:
        for session_number, urls in item.items():
            session = {
                "number": session_number,
                "talks": []
            }

            for url in urls:
                URL = f"{url}{langCode}"
                page = requests.get(URL)

                soup = BeautifulSoup(page.content, "html.parser")
                paragraphs_raw = soup.select("div.body-block p")

                title = soup.select("header h1")[0].get_text()
                author = soup.select("p.author-name")[0].get_text()
                calling = soup.select("p.author-role")[0].get_text()
                subject = soup.select("p.kicker")[0].get_text();


                paragraphs = []
                

                for p in paragraphs_raw:
                    paragraphs.append(p.get_text())

                talk = {
                    "title": title,
                    "author": author,
                    "calling": calling,
                    "subject": subject,
                    "paragraphs": paragraphs
                }
                session["talks"].append(talk)
            talk_data["October-2026"].append(session)           
    json_data = json.dumps(talk_data, indent=4)

    # file_path = "/Users/michaelknight/Documents/talkData/english-oct-2026.json"
    # file_path = "/Users/michaelknight/Documents/talkData/tagalog-oct-2026.json"
    # file_path = "/Users/michaelknight/Documents/talkData/spanish-oct-2026.json"
    file_path = "/Users/michaelknight/Documents/talkData/cebuano-oct-2026.json"

    with open(file_path, 'w') as file:
        file.write(json_data)

scrape_conference_talks()

