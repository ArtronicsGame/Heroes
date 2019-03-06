extends Control

onready var home_scene = preload("res://Scenes/Scenes/GUI/Home.tscn")
onready var shop_scene = preload("res://Scenes/Scenes/GUI/Shop.tscn")
onready var items_scene = preload("res://Scenes/Scenes/GUI/Items.tscn")
onready var auction_scene = preload("res://Scenes/Scenes/GUI/Auction.tscn")
onready var chests_scene = preload("res://Scenes/Scenes/GUI/Chests.tscn")
onready var inapp_scene = preload("res://Scenes/Scenes/GUI/InApp.tscn")
onready var clans_scene = preload("res://Scenes/Scenes/GUI/Clans.tscn")


var curr_node;

func _ready():
	var home = home_scene.instance()
	add_child(home)
	curr_node = home


func _on_HomeBtn_pressed():
	remove_child(curr_node)
	var home = home_scene.instance()
	add_child(home)
	curr_node = home


func _on_shopBtn_pressed():
	remove_child(curr_node)
	var shop = shop_scene.instance()
	add_child(shop)
	curr_node = shop

func _on_ItemsBtn_pressed():
	remove_child(curr_node)
	var items = items_scene.instance()
	add_child(items)
	curr_node = items


func _on_ClansBtn_pressed():
	remove_child(curr_node)
	var clans = clans_scene.instance()
	add_child(clans)
	curr_node = clans


func _on_ChestsBtn_pressed():
	remove_child(curr_node)
	var chests = chests_scene.instance()
	add_child(chests)
	curr_node = chests


func _on_AuctionBtn_pressed():
	remove_child(curr_node)
	var auction = auction_scene.instance()
	add_child(auction)
	curr_node = auction


func _on_InAppBtn_pressed():
	remove_child(curr_node)
	var inapp = inapp_scene.instance()
	add_child(inapp)
	curr_node = inapp


