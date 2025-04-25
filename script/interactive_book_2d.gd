extends AnimatedSprite2D
class_name InteractiveBook2D

@onready var pagelabel = $RichTextLabel
var current_page := 0
var page_text := [""]  # Initialize with an empty array to store page contents
var page_count := 0

# Initialize pages with content
func init_page(attacker: bool, level_id: int, level_loader_ref):
	var LevelLoader = level_loader_ref
	var level_data = LevelLoader.GetLevelData(attacker, level_id)

	page_text.clear()

	# Page 0: Title
	page_text.append("[b][center][color=white]\n\n%s[/color][/center][/b]" % level_data[0])

	# Page 1: Description
	page_text.append("[b]Description:[/b]\n" + level_data[1])
	
	# Page 4: Codex Entry
	# Page 4+: Codex Pages
	if level_data[7].size() > 0:
		for entry_index in level_data[7].size():
			var codex_entry = level_data[7][entry_index]
			page_text.append("\n%s" % [codex_entry])
	else:
		page_text.append("\n\n[b]Codex Entry:[/b]\n[i]No entry available for this level.[/i]")

	page_text.append("")

	# Set page count and display
	page_count = page_text.size() 
	current_page = 0
	update_page_text()

func update_page_text():
	if current_page >= 0 and current_page < page_text.size():
		pagelabel.clear()
		pagelabel.append_text(page_text[current_page])
	else:
		print("Invalid page index: ", current_page)

# - Set the book to be closed when the scene is loaded
func _ready():
	current_page = 0
	go_to_page(current_page)
	connect("animation_finished", Callable(self, "_on_animation_finished"))
	update_page_text()

# - Use this to always get a page number that is within the set page count
# - Cycles the number when a value outside the accepted range is provided
func clamp_current_page(new_page : int) -> int:
	# If new_page is less than 0, go to the last page
	if new_page < 0:
		new_page = page_count
	# - number greater than the page count are interpreted as wanting to go back to the first
	elif new_page > page_count:
		new_page = 0
	return new_page

# - Handle page transition logic with animations
func go_to_page(page : int):
	# do nothing if already at the given page
	if current_page == page:
		return
	# do nothing if given a negative number or a number outside the page count
	if page < 0 or page > page_count:
		return
		
	pagelabel.visible = false
	
	# going to the first page - closed from front
	if page == 0:
		if current_page == 1: # on the first page
			play("close_from_first") # play animation for closing the book from the first page
		elif current_page == page_count: # book closed from back
			play("closed_front") # go directly to closed front animation. As if flipping the book
			current_page = 0
			pagelabel.visible = true
			update_page_text()
			return # skip the rest
		else: # close from the middle otherwise
			play("close_from_middle")
	# going to the last page - closed from back
	elif page == page_count:
		if current_page == page_count - 1: # on the last page
			play("close_from_last") # play animation for closing the book from the last page
		elif current_page == 0: # book closed from front
			play("closed_back") # go directly to closed front animation. As if flipping the book
	# going to the first page
	elif page == 1:
		if current_page == 0: # currently closed from front
			play("open_to_first") # open the book to the first page
		elif current_page == 2: # on the second page
			play("previous_to_first") # go back to the first page
	# going to the last page
	elif page == page_count - 1:
		if current_page == page_count: # currently closed from back
			play("open_to_last") # open to the last page
		if current_page == page_count - 2: # on the second to last page
			play("next_to_last") # go to the last page
	# going to second page from fist
	elif page == 2 and current_page == 1:
		play("next_from_first")
	# going to second last page from last
	elif page == page_count - 2 && current_page == page_count - 1:
		play("previous_from_last")
	# going to any middle page
	else:
		if page > current_page: # play next page if next page number is greater
			play("next_page")
		elif page < current_page: # play previous page if next page number is lesser
			play("previous_page")
	
	current_page = page # set current page to the new page


# Button logic for cycling through pages
func _on_next_page_button_button_down():
	go_to_page(clamp_current_page(current_page + 1))

func _on_previous_page_button_button_down():
	go_to_page(clamp_current_page(current_page - 1))

func _on_close_button_button_down():
	go_to_page(0)  # Close book to first page

func _on_animation_finished():
	print("Animation finished. Current page:", current_page)
	pagelabel.visible = true  # Show the label after animation ends
	update_page_text()  # Make sure text is refreshed
