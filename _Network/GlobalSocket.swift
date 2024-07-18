import UIKit

protocol GlobalSocketDelegate: AnyObject {
    func receivedData()
}

class GlobalSocket: NSObject {
        
    static let shared = GlobalSocket()
    
    private var session: URLSession!
    private var webSocketTask: URLSessionWebSocketTask!
    
    weak var delegate: GlobalSocketDelegate?
    
    var jsonData: JSON!
    
//    func reconectGlobalSocket() {
//        if session == nil { return }
//        if webSocketTask.state == .completed {
//            connect()
//        }
//    }
    
    func connect() {
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        guard let url = URL(string: "wss://box-test.boxbattle.ru/ws/") else {
            print("error url GlobalSocket")
            return
        }
        var request = URLRequest(url: url)
        NetworkServices.shared.networkManager.setCookieInRequest(&request)
        webSocketTask = session.webSocketTask(with: request)
        print("stststs1: \(GlobalSocket.shared.webSocketTask.state)")
        webSocketTask.resume()
    }
    
    func disconnect() {
        if webSocketTask == nil { return }
        webSocketTask.cancel(with: .goingAway, reason: nil)
    }
    
    private func connected() {
        webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                print("connected webSocket failure: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    do {
                        self.jsonData = try JSON(data: text.data(using: .utf8)!)
                        if self.jsonData != nil {
                            self.checkTypeMessages()
                            self.connected()
                            self.delegate?.receivedData()
                        }
                    } catch let error {
                        print("connected webSocket error: \(error)")
                    }
                case .data(let data):
                    print("Received binary message: \(data)")
                @unknown default:
                    fatalError()
                }
            }
        }
    }
    
    func send(parameters: [String: Any]) {
        do {
            let jsonData = try JSON(parameters).rawData()
            let string = String(decoding: jsonData, as: UTF8.self)
            webSocketTask.send(.string(string)) { error in
                if let error = error {
                    print("error send msg GlobalSocket: \(String(describing: error))")
                    GlobalSocket.shared.connect()
                }
            }
        } catch {
//            ErrorApp.shared.showError(message: "Error send message in GlobalSocket: \(parameters)")
            GlobalSocket.shared.connect()
        }
    }
}


extension GlobalSocket: URLSessionWebSocketDelegate {
    
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        GlobalSocket.shared.send(parameters: ["type": "change_location", "data": ["location_id": 0]])
        // проверка есть ли запущенные активности (идущие бои)
        GlobalSocket.shared.send(parameters: ["type": "update_player_state"])
//        DispatchQueue.main.async {
//            if GetCurrentVC.get_() is SplashVC || GetCurrentVC.get_() is AuthWebVC {
//                appDelegate.goToGame()
//            }
//        }
        connected()
    }

    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
    }
}


extension GlobalSocket {
    
    func checkTypeMessages() {
             
        print("checkTypeMessages: \(jsonData["type"].stringValue)")
        
//        switch jsonData["type"].stringValue {
//            
//        case "back_to_arena",
//            "change_location",
//            "competition_lobby_exit",
//            "competition_update_state",
//            "competition_gathering_invite_deny",
//            "drop_task_timer": // удаление таймера задания в квесте, не нужно обрабатывать это сообщение тк удаляются и создаются таймеры на каждом контроллере
//            return
//            
//        case "error":
//            print("ERROR: \(jsonData ?? "")")
//            
//        case "disconnect":
//            print("disconnect msg socket")
//            switch jsonData["data"]["reason"].stringValue {
//            case "another_device_login":
//                DispatchQueue.main.async {
//                    let vc = ModalDisconnectVC()
//                    vc.modalPresentationStyle = .overFullScreen
//                    GetCurrentVC.get_().present(vc, animated: true)
//                }
//                
//            case "player_is_deleted":
//                ErrorApp.shared.showError(message: "player_is_deleted")
//            default:
//                print("SOCKET DISCONNECT: \(String(describing: jsonData))")
//            }
//            
//        case "update_players", "player_list_change":
//            delegate?.receivedData()
//            
//        case "update_locations":
//            delegate?.receivedData()
//            
//        case "get_players_from_realm":
//            delegate?.receivedData()
//            
//        case "achievement":
//            print("achievement !!!!!")
//            GeneralViewController.getAchievement(json: GlobalSocket.shared.jsonData["data"])
//            
//        case "battle":
//            // соперник прислал приглашение и я принял его
//            Config.shared.urlBattle = jsonData["data"]["url"].stringValue
//            BattleSocket.shared.connect(link: Config.shared.getUrlBattleSocket(), state: .battleLocation)
//            
//        case "call", "invite":
//            // противник вызвал на бой - показ модалки с приглашением
//            DispatchQueue.main.async {
//                GetCurrentVC.get_().presentBottomSheet(viewController: ModalInviteInBattleVC())
//            }
//            
//            // противник отклонил свой вызов (передумал)
//            // я вызвал соперника и он отменил вызов
//        case "cancel", "deny":
//            OpenVC.openModalOpponentDenyInviteVC(type: jsonData!["type"].stringValue)
//            
//        case "call_timeout_reciever", "invite_timeout_reciever":
//            // call_timeout_reciever - соперник прислал приглашение и кончилось время ожидания ответа
//            // invite_timeout_reciever - соперник прислал приглашение по пушу и кончилось время ожидания ответа
//            GetCurrentVC.get_().dismiss(animated: true)
//            
//        case "call_state":
//            // я вызвал и жду ответа от соперника
//            OpenVC.openModalWaitOpponent()
//            
//        case "call_timeout_caller", "invite_timeout_caller":
//            // кончилось время ожидания когда я вызвал
//            // invite_timeout_caller - я вызвал соперника и кончилось время ожидания ответа
//            OpenVC.openModalInviteInBattleAgainVC()
//            
//        case "accept":
//            // соперник принял вызов (показ модалки)
//            DispatchQueue.main.async {
//                GetCurrentVC.get_().dismiss(animated: true)
//            }
//            
//        case "history_invites":
//            // история приглашений
//            delegate?.receivedData()
//
//        case "tdr":
//            // запуск раунда башни
//            delegate?.receivedData()
//            
//        case "notification":
//            NotificationsApp.shared.getN { }
//            
//        case "chat_message":
//            TempData.newComment = jsonData
//            NotificationsApp.shared.getN { }
//            
//        case "quest_completed":
//            print("quest_completed")
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                let vc = ModalQuestCompleteVC()
//                vc.json = self.jsonData
//                GetCurrentVC.get_().presentBottomSheet(viewController: vc)
//            }
//            
//        case "competition_lobby_enter":
//            delegate?.receivedData()
//            
//        case "competition_lobby_update_state",
//            "competition_lobby_update_players",
//            "competition_lobby_remove_players":
//            delegate?.receivedData()
//            
//        case "competition_gathering_start":
//            GlobalSocket.shared.send(parameters: ["type": "competition_gathering_join",
//                                                  "data": ["competition_id": SelectObject.competition.id]])
//            
//        case "competition_gathering_join":
//            GlobalSocket.shared.send(parameters: ["type": "competition_lobby_update_state",
//                                                  "data": ["competition_id": SelectObject.competition.id]])
//            
//        case "competition_gathering_leave":
//            delegate?.receivedData()
//            GlobalSocket.shared.send(parameters: ["type": "competition_lobby_update_state",
//                                                  "data": ["competition_id": SelectObject.competition.id]])
//            
//        case "competition_gathering_invite":
//            switch gCurrentUserData.state {
//            case .none, .online, .ready:
//                DispatchQueue.main.async {
//                    GetCurrentVC.get_().presentBottomSheet(viewController: ModalInviteInCompetitionVC())
//                }
//            default:
//                break
//            }
//            
//        case "competition_gathering_invite_accept":
//            // принял приглашение учавствовать в турнире
//            DispatchQueue.main.async {
//                OpenVC.openGathering()
//            }
//            GlobalSocket.shared.send(parameters: ["type": "competition_lobby_enter",
//                                                  "data": ["competition_id": SelectObject.competition.id]])
//            GlobalSocket.shared.send(parameters: ["type": "competition_gathering_join",
//                                                  "data": ["competition_id": SelectObject.competition.id]])
//            
//        case "update_object":
//            print("!!!!!  update_object")
//            
//        case "update_player_state":
//            CheckStartedBattles.check()
//            
//        case "competition_search_players":
//            delegate?.receivedData()
//            
//        case "competition_team_invite_player":
//            DispatchQueue.main.async {
//                GetCurrentVC.get_().hideLoader()
//                // SFSymbol
//                let configuration = UIImage.SymbolConfiguration(pointSize: 64, weight: .regular)
//                let icon = UIImage(systemName: "checkmark.circle", withConfiguration: configuration)
//                let alert = AlertIcon(title: gDict["sd1"].stringValue, message: nil, preferredStyle: .alert)
//                alert.setTitleImage(icon, tintColor: .BB_PrimaryUI)
//                let action = UIAlertAction(title: gDict["ok"].stringValue, style: .default) { _ in
//                    GetCurrentVC.get_().navigationController?.popViewController(animated: true)
//                }
//                action.setValue(UIColor.BB_BGPrimary, forKey: "titleTextColor")
//                alert.addAction(action)
//                GetCurrentVC.get_().present(alert, animated: true)
//            }
//            
//        case "battles_with_one_player":
//            DispatchQueue.main.async {
//                GetCurrentVC.get_().presentBottomSheet(viewController: WarningAntiAchivementVC())
//            }
//            
//        case "competition_team_invite":
//            DispatchQueue.main.async {
//                SelectObject.competition = Competition(id: self.jsonData["data"]["competition_id"].intValue,
//                                                       name: self.jsonData["data"]["competition_name"].stringValue,
//                                                       maxPlayers: self.jsonData["data"]["players_max"].intValue,
//                                                       myTeamID: self.jsonData["data"]["team_id"].intValue,
//                                                       myTeamName: self.jsonData["data"]["team_name"].stringValue,
//                                                       myTeamPlayers: self.jsonData["data"]["players_count"].intValue,
//                                                       myTeamAvatar: self.jsonData["data"]["team_image_url"].stringValue)
//                
//                SelectObject.team = Team(id: self.jsonData["data"]["team_id"].intValue,
//                                         name: self.jsonData["data"]["team_name"].stringValue,
//                                         players: self.jsonData["data"]["players_count"].intValue,
//                                         avatar: self.jsonData["data"]["team_image_url"].stringValue,
//                                         maxPlayers: self.jsonData["data"]["players_max"].intValue,
//                                         competitionName: self.jsonData["data"]["competition_name"].stringValue,
//                                         competitionID: self.jsonData["data"]["competition_id"].intValue)
//                GetCurrentVC.get_().presentBottomSheet(viewController: ModalIInvitePlayerInTeamVC())
//            }
//            
//        case "module_complete":
//            print("!!!!! mmodule_complete")
//            
//        case "report_result":
//            ReportComplete.shared.showLocalMessage(status: jsonData["data"]["status"].stringValue,
//                                                   nameReport: jsonData["data"]["name"].stringValue)
//            
//        case "stage_finished":
//            print("stage_finished")
//            DispatchQueue.main.async {
//                GetCurrentVC.get_().presentBottomSheet(viewController: MarathonStageFinishedVC())
//            }
//            
//        case "stage_skipped":
//            print("stage_skipped_____")
//            
//        case "marathon_finished":
//            DispatchQueue.main.async {
//                GetCurrentVC.get_().presentBottomSheet(viewController: MarathonFinishedVC())
//            }
//            
//        case "appoint_progress":
//            delegate?.receivedData()
//            
//        default:
//            print(">>>>>> Не обрабатывается сообщение Gsocket: \(jsonData["type"].stringValue)")
//        }
    }
}
