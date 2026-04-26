//
//  Upgrade Packages.swift
//  Cork
//
//  Created by David Bureš on 04.07.2022.
//

import CorkShared
import CorkTerminalFunctions
import Defaults
import Foundation
import SwiftUI
import CorkModels
import BetterProgress

extension OutdatedPackagesTracker
{
    @MainActor
    func updatePackages(
        updateProgressTracker: UpdateProgressTracker
    ) async
    {
        let includeGreedyPackages: Bool = Defaults[.includeGreedyOutdatedPackages]
        
        let totalCases: Int = UpdateProgressTracker.UpdateProcessMatcher.allCases.count
        
        /// The step number for switching update stages
        /// The number of packages that are being updated, divided by the number of process steps
        let incrementalProgress: Progress = .init(
            parent: updateProgressTracker.updateProgress,
            percentageOfParentToTakeUp: 100,
            totalItemsOfThisProgress: totalCases
        )
        
        incrementalProgress.increment(byPercentage: 30)
        
        /*
        for await output in shell(AppConstants.shared.brewExecutablePath, ["upgrade", includeGreedyPackages ? "--greedy" : ""])
        {
            updateProgressTracker.insertOutput(output)
            
            output.match(as: UpdateProgressTracker.UpdateProcessMatcher.self) { standardOutputCase in
                updateProgressTracker.fullUpdateStage = standardOutputCase
                
                switch standardOutputCase
                {
                case .downloading:
                    updateProgressTracker.updateProgress = .discreteProgress(totalUnitCount: progressStep)
                case .pouring:
                    <#code#>
                case .cleanup:
                    <#code#>
                case .backingUp:
                    <#code#>
                case .linking:
                    <#code#>
                }
            } onUnimplementedOutput:
            { unimplementedOutput in
                self.appConstants.logger.info("Unimplemented output for updater: \(unimplementedOutput.description, privacy: .public)")
            }

        }
         */
    }
}

/*
 @MainActor
 func updatePackages(updateProgressTracker: UpdateProgressTracker, detailStage: UpdatingProcessDetails) async
 {
     let showRealTimeTerminalOutputs: Bool = UserDefaults.standard.bool(forKey: "showRealTimeTerminalOutputOfOperations")
     let includeGreedyPackages: Bool = UserDefaults.standard.bool(forKey: "includeGreedyOutdatedPackages")

     for await output in shell(AppConstants.shared.brewExecutablePath, ["upgrade", includeGreedyPackages ? "--greedy" : ""])
     {
         switch output
         {
         case .standardOutput(let outputLine):
             AppConstants.shared.logger.log("Upgrade function output: \(outputLine, privacy: .public)")

             if showRealTimeTerminalOutputs
             {
                 updateProgressTracker.realTimeOutput.append(RealTimeTerminalLine(line: outputLine))
             }

             if outputLine.contains("Downloading")
             {
                 detailStage.currentStage = .downloading
             }
             else if outputLine.contains("Pouring")
             {
                 detailStage.currentStage = .pouring
             }
             else if outputLine.contains("cleanup")
             {
                 detailStage.currentStage = .cleanup
             }
             else if outputLine.contains("Backing App")
             {
                 detailStage.currentStage = .backingUp
             }
             else if outputLine.contains("Moving App") || outputLine.contains("Linking")
             {
                 detailStage.currentStage = .linking
             }
             else
             {
                 detailStage.currentStage = .cleanup
             }

             AppConstants.shared.logger.info("Current updating stage: \(detailStage.currentStage.description, privacy: .public)")

             updateProgressTracker.updateProgress = updateProgressTracker.updateProgress + 0.1

         case .standardError(let errorLine):

             if showRealTimeTerminalOutputs
             {
                 updateProgressTracker.realTimeOutput.append(RealTimeTerminalLine(line: errorLine))
             }

             if errorLine.contains("tap") || errorLine.contains("No checksum defined for")
             {
                 updateProgressTracker.updateProgress = updateProgressTracker.updateProgress + 0.1

                 AppConstants.shared.logger.log("Ignorable upgrade function error: \(errorLine, privacy: .public)")
             }
             else
             {
                 AppConstants.shared.logger.warning("Upgrade function error: \(errorLine, privacy: .public)")
                 updateProgressTracker.errors.append("Upgrade error: \(errorLine)")
             }
         }
     }

     updateProgressTracker.updateProgress = 9
 }

 */
