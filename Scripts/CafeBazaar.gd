extends Node2D

const PurchaseTemp = preload("utils/Purchase.gd")
const IabResultTemp = preload("utils/IabResult.gd")
const SkuDetailsTemp = preload("utils/SkuDetails.gd")
const InventoryTemp = preload("utils/Inventory.gd")

#onready var cafeBazaarIAB = Engine.get_singleton("CafeBazaarIAB")
var cafeBazaarIAB

signal on_iab_setup_finished(result)
signal on_iab_purchase_finished(result, purchase)
signal on_iab_consume_finished(result, purchase)
signal on_query_inventory_finished(result, inventory)

func _ready():
	cafeBazaarIAB.setCallbackId(get_instance_id())
	pass

func startSetup(key):
	cafeBazaarIAB.connect(key)

func onIabSetupFinished(response, message):
	var result = IabResultTemp.new(response, message)
	emit_signal("on_iab_setup_finished", result)

func onIabPurchaseFinished(response, message, itemType, json, signature):
	var result = IabResultTemp.new(response, message)
	if result.isSuccess():
		var purchase = PurchaseTemp.new(itemType, json, signature)
		emit_signal("on_iab_purchase_finished", result, purchase)
	else:
		emit_signal("on_iab_purchase_finished", result, "Null")

func onConsumeFinished(response, message, itemType, json, signature):
	var result = IabResultTemp.new(response, message)
	if result.isSuccess():
		var purchase = PurchaseTemp.new(itemType, json, signature)
		emit_signal("on_iab_consume_finished", result, purchase)
	else:
		emit_signal("on_iab_consume_finished", result, "Null")

func onQueryInventoryFinished(response, message, purchaseJson, skusJson):
	var result = IabResultTemp.new(response, message)
	if result.isSuccess():
		var inventory = InventoryTemp.new(purchaseJson, skusJson)
		emit_signal("on_query_inventory_finished", result, inventory)
	else:
		emit_signal("on_query_inventory_finished", result, "Null")

func launchPurchaseFlow(sku, developerPayload):
	cafeBazaarIAB.purchase(sku, developerPayload)

func consumeAsync(purchase):
	cafeBazaarIAB.consume(purchase.mItemType, purchase.mOriginalJson, purchase.mSignature)

func queryInventoryAsync(details, skus):
	var skuString = ""
	for sku in skus:
		skuString += sku
		skuString += ";"
	skuString = skuString.substr(0, skuString.length() - 1)
	cafeBazaarIAB.queryInventory(details, skuString)
