//
//  Update All Packages View.swift
//  Cork
//
//  Created by David Bureš - P on 24.04.2026.
//

import SwiftUI
import FactoryKit
import CorkModels

struct UpdateAllPackagesView: View
{
    @Environment(UpdateProgressTracker.self) var updateProgressTracker: UpdateProgressTracker
    @InjectedObservable(\.outdatedPackagesTracker) var outdatedPackagesTracker: OutdatedPackagesTracker
    
    @Observable
    final class FullUpdateStageTracker
    {
        var currentStage: UpdateProgressTracker.UpdateProcessMatcher.StandardCases
        
        public init()
        {
            self.currentStage = .downloading
        }
    }
    
    @State private var fullUpdateStageTracker: FullUpdateStageTracker = .init()
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            ProgressView(updateProgressTracker.updateProgress)
            
            updateProgressTracker.streamedOutputsDisplay
        }
        .toolbar
        {
            ToolbarItem(placement: .automatic)
            {
                Text(fullUpdateStageTracker.currentStage.description)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .task {
            await outdatedPackagesTracker.updatePackages(updateProgressTracker: updateProgressTracker)
        }
    }
}
