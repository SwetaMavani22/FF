//
//  UIController+Ext.swift
//  mExpense
//
//  Created by user1 on 26/10/21.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    
    func gotoOTPverificationVC(authToken : String , PhoneNumber : String) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: OTPverificationVC.self)
        vc.authToken = authToken
        vc.PhoneNumber = PhoneNumber
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoPersonalProfileVC(isFromUpdate : Bool) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: PersonalProfileVC.self)
        vc.isFromUpdate = isFromUpdate
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoBussinessProfileVC(isFromUpdate : Bool) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: BussinessProfileVC.self)
        vc.isFromUpdate = isFromUpdate
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoAddProductVC(isFromUpdate : Bool , selectedProduct : ModelProductList , isFromCreateBusiness : Bool) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: AddProductVC.self)
        vc.isFromUpdate = isFromUpdate
        vc.selectedProduct = selectedProduct
        vc.isFromCreateBusiness = isFromCreateBusiness
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoProductListVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: ProductListVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoProductDescVC(selectedProduct : ModelProductList , isFromAllProduct : Bool) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: ProductDescVC.self)
        vc.selectedProduct = selectedProduct
        vc.isFromAllProduct = isFromAllProduct
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoPersonalMapVCFromPersonalProfile(Lat : Double , Long : Double , controller : PersonalProfileVC) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: PersonalMapVC.self)
        vc.LAT = Lat
        vc.LONG = Long
        vc.delegate = controller
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoPersonalMapVCFromBusinessProfile(Lat : Double , Long : Double , controller : BussinessProfileVC) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: PersonalMapVC.self)
        vc.LAT = Lat
        vc.LONG = Long
        vc.delegate = controller
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoChatVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: ChatVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoNotificationVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: NotificationVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoOtherUserProfileVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: OtherUserProfileVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoUserProfileVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: UserProfileVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoHomeVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: HomeVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoRequestVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: RequestVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoSettingVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: SettingVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoBlockContactVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: BlockContactVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoChangeNumberVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: ChangeNumberVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoContactUsVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: ContactUsVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoHelpVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: HelpVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoMessageVC(isFromInquiry : Bool) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: MessageVC.self)
        vc.isFromInquiry = isFromInquiry
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoMarketingVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: MarketingVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoUserListMapVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: UserListMapVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoLikeCommentVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: LikeCommentVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoCreateGroupVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: CreateGroupVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoNewProductListVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: NewProductListVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoGroupDetailsVC(selectedUser : [String]) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: GroupDetailsVC.self)
        vc.arrSelectedUser = selectedUser
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoPromotionBaseVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: PromotionBaseVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoCreateNotificationVC(isUpdate : Bool) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: CreateNotificationVC.self)
        vc.isUpdate = isUpdate
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoPromotionPlanVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: PromotionPlanVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
    func gotoStartPromotionVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: StartPromotionVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoSelectUserVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: SelectUserVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoPromotionDataAndTimeVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: PromotionDataAndTimeVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoPromotionBillVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: PromotionBillVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoApplyCouponVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: ApplyCouponVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoPaymentVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: PaymentVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoPaymentSuccesVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: PaymentSuccesVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoBillDetailsVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: BillDetailsVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoHistoryDetailsVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: HistoryDetailsVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoSelectPackageVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: SelectPackageVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoAudioCallVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: AudioCallVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoVideoCallVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: VideoCallVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoPersonalInfoVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: PersonalInfoVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoGroupDetailVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: GroupDetailVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoEditGroupDetailsVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: EditGroupDetailsVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func gotoShowReelsVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: ShowReelsVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoUploadReelsVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: UploadReelsVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }


    /*func gotoCreateInvoiceVC(isUpdate : Bool, selectedInvoiceDate : CreateInvoice , lastCreateInvoice : Date? ,isLastCreateInvoice : Bool ) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: CreateInvoiceVC.self)
        vc.lastCreateInvoice = lastCreateInvoice ?? Date()
        vc.isLastCreateInvoice = isLastCreateInvoice
        vc.isUpdate = isUpdate
        vc.selectedInvoiceDate = selectedInvoiceDate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoInvoiceHistoryVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: InvoiceHistoryVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoManageProductsVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: ManageProductsVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoManageCustomersVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: ManageCustomersVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoAddCustomerVC(isUpdate : Bool , selectedCustomer : ManageCustomer) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: AddCustomerVC.self)
        vc.isUpdate = isUpdate
        vc.selectedCustomer = selectedCustomer
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoMyBusinessVC() {
        DispatchQueue.main.async {
            let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: MyBusinessVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func gotoAppTrans() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: ViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoBillProductsVC(isGST : Bool , Invoice_UID : Date , isUpdate : Bool , invoiceDetail: NSManagedObject? , selectedInvoiceDate : CreateInvoice , lastCreateInvoice : Date? ,isLastCreateInvoice : Bool ,isStateMatch : Bool) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: BillProductsVC.self)
        vc.isStateMatch = isStateMatch
        vc.lastCreateInvoice = lastCreateInvoice ?? Date()
        vc.isLastCreateInvoice = isLastCreateInvoice
        vc.isGST = isGST
        vc.Invoice_UID = Invoice_UID
        vc.isUpdate = isUpdate
        vc.invoiceDetail = invoiceDetail
        vc.selectedInvoiceDate = selectedInvoiceDate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoAddProductVC(isUpdate : Bool , selectedProduct : ManageProduct) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: AddProductVC.self)
        vc.isUpdate = isUpdate
        vc.selecteProduct = selectedProduct
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoInvoiceAddProductVC(isGST : Bool , isUpdate : Bool ,selectedProduct : ManageInvoiceProduct , Invoice_UID : Date) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: InvoiceAddProductVC.self)
        vc.isGST = isGST
        vc.isUpdate = isUpdate
        vc.selectedProduct = selectedProduct
        vc.Invoice_UID = Invoice_UID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoSummaryVC(isGST : Bool, Invoice_UID : Date , subTotal : Double , isUpdate : Bool, invoiceDetail: NSManagedObject?, selectedInvoiceDate : CreateInvoice , lastCreateInvoice : Date? ,isLastCreateInvoice : Bool,isStateMatch : Bool) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: SummaryVC.self)
        vc.isStateMatch = isStateMatch
        vc.lastCreateInvoice = lastCreateInvoice ?? Date()
        vc.isLastCreateInvoice = isLastCreateInvoice
        vc.isGST = isGST
        vc.Invoice_UID = Invoice_UID
        vc.subTotal = subTotal
        vc.isUpdate = isUpdate
        vc.invoiceDetail = invoiceDetail
        vc.selectedInvoiceDate = selectedInvoiceDate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoSettingsVC() {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: SettingsVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoInvoiceVC(billProductData : [ManageInvoiceProduct] , invoiceData : CreateInvoice) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: InvoiceVC.self)
        vc.billProductData = billProductData
        vc.invoiceData = invoiceData
        self.navigationController?.pushViewController(vc, animated: true)
    }*/
}
