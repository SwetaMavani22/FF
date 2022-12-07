//
//  Constants.swift
//  ChannelBusiness

import Foundation
import UIKit

var appName = "Friends Field"
var Defualtss = UserDefaults.standard

var alertMissing = "Sorry we can’t found, something is missing!"
var alertNetwork = "Please check your internet connection!"

struct CONTROLLER {
    static let OtherUserProfileVC = "OtherUserProfileVC"
    static let UserProfileVC = "UserProfileVC"

}
//var BussinessDetails = ModelBussinesDetails()

struct colors {
    static let ThemeSky =  "5AC8D2"
    static let ThemeGray =  "F0F0F0"
    static let ThemeLightSky = "DFFDFF"
    static let SegmentGrayColor = "888888"
}

struct UDKey {
    static let kUserData =  "UserData"
    static let kUserToken =  "UserToken"
    static let kUserBussinesData =  "UserBussinesData"
    static let kIsFaceLock =  "IsFaceLock"
    static let ISBussinesProfileCreate =  "ISBussinesProfileCreate"
    static let ISPersonalProfileCreate =  "ISPersonalProfileCreate"
}

struct MsgType {
    static let Text =  "TextMessgae"
    static let Image =  "ImageMessage"
}

func isValidEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

func isValidGST(gst: String) -> Bool {
    let gstRegEx = "^([0][1-9]|[1-2][0-9]|[3][0-7])([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", gstRegEx)
    return emailPred.evaluate(with: gst)
}

struct Cell {
    static let numberPadCell = "SCNumberPadCell"
    static let videoCell = "SCVideoCell"
    static let menuCell = "SCMenuCell"
    static let sendMsgCell = "SenderMsgCell"
    static let receiveMsgCell = "ReceiverMsgCell"
    static let chatSendImageCell = "ChatImageCell"
    static let chatReciveImageCell = "ReciveChatImageCell"
    static let chatRecivePdfCell = "ReciveChatPdfCell"
    static let reciveChatvideoCell = "ReciveChatvideoCell"
    static let senderChatvideoCell = "SenderChatVideoCell"
    static let senderVideoMetaCell = "SenderVideoMetadataCell"
    static let senderImageMetaCell = "SenderImageMetadataCell"
    static let senderPdfMetaCell = "SenderPdfMetadataCell"
    static let reciverVideoMetaCell = "ReciverVideoMetadataCell"
    static let reciverImageMetaCell = "ReciverImageMetadataCell"
    static let reciverPdfMetaCell = "ReciverPdfMetadataCell"
    
    static let deleteCell = "DeleteCell"
    static let chatSendPdfCell = "PdfCell"
    static let acceptRejectCell = "SCAcceptRejectCell"
    static let appointmentDetailsCell = "AppointmentDetailsCell"
    static let appointmentListCell = "AppointmentListCell"
    static let infoCell = "InfoCell"
    static let callBtnCell = "CallBtnCell"
    static let permanentRoomListCell = "PermanentRoomListCell"
    static let labelCell = "LabelCell"
    static let slctMemberCell = "SelectMemberCell"
    static let accordianSmallCell = "AccordianSmallCell"
    static let accordianExpandedCell = "AccordianExpandedCell"
    static let docSmallCell = "DocSmallCell"
    static let docExpandedCell = "DocExpandedCell"
    static let searchHeaderCell = "SearchHeaderCell"
    static let labelHeaderCell = "LabelHeaderCell"
    static let currentParticipantsCell = "CurrentParticipantsCell"
    static let contactsCollectionCell = "ContactsCollectionCell"
    static let videoCallCell = "VideoCallCell"
    static let previewCell = "PreviewCell"
    static let appointmentCell = "AppointmentCell"
    static let faxLogCell = "FaxLogCell"
    static let faxLogExpandedCell = "FaxLogExpandedCell"
    static let notificationExtendedCell = "NotificationExtendedCell"
    static let notificationCollapsedCell = "NotificationCollapsedCell"
    static let notiFaxExpandedCell = "NotiFaxExpandedCell"
    static let notiBtnCell = "NotiBtnCell"
    static let teamMembersCell = "TeamMembersCell"
    static let shareLinkCell = "ShareLinkCell"
    static let linkShareCell = "LinkShareCell"
    static let linkCell = "LinkCell"
    static let reciverLinkMetaCell = "ReciverLinkMetaCell"
    static let senderLinkMetaCell = "SenderLinkMetaCell"
}
