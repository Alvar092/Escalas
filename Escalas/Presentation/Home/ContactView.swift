//
//  ContactView.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 23/2/26.
//

import SwiftUI
import MessageUI

struct ContactView: View {
    
    @State private var showMailComposer = false
    @State private var mailError = false
    
    let feedbackMail = "deventrena@gmail.com"
    
    var body: some View {
        VStack(spacing: 25) {
            Spacer()
            
            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundStyle(.red)
            
            Text("home.contact.title")
                .font(.mSemi)
                .foregroundStyle(.textPrim)
                .multilineTextAlignment(.center)
            
            Text("home.contact.body")
                            .font(.m)
                            .foregroundStyle(.textPrim)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
            
            Button {
                if MFMailComposeViewController.canSendMail() {
                    showMailComposer = true
                } else {
                    if let url = URL(string: "mailto:\(feedbackMail)") {
                        UIApplication.shared.open(url)
                    }
                }
            } label: {
                Label("home.contact.sendFeedback", systemImage: "envelope.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.prim)
                    .foregroundStyle(.textOnPrim)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color(.backg))
        .sheet(isPresented: $showMailComposer) {
            MailComposerView(recipient: feedbackMail, subject: "Feedback App")
        }
        .alert("home.contact.noMail", isPresented: $mailError) {
            Button("OK", role: .cancel) {}
        }
    }
}

struct MailComposerView: UIViewControllerRepresentable {
    let recipient: String
    let subject: String
    @Environment(\.dismiss) var dismiss

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setToRecipients([recipient])
        vc.setSubject(subject)
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(dismiss: dismiss)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let dismiss: DismissAction

        init(dismiss: DismissAction) {
            self.dismiss = dismiss
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            dismiss()
        }
    }
}

#Preview {
    ContactView()
}
