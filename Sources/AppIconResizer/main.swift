import Foundation
import AppKit

let version = "0.0.1"

enum AppIconResizerError: Error {
    case invalidArgument(String)
    case loadFailure(String)
    case notAnImage(String)
    case couldNotWriteImage(String)
}

enum CommandArgument {
    case help
    case version
    case inputFileName(fileName: String)
    case outputDirectory(directory: String)
    
    static func parseArguments(_ arguments: [String]) throws -> [CommandArgument] {
        var result = [CommandArgument]()
        var argumentIndex = 1
        
        while argumentIndex < arguments.count {
            switch arguments[argumentIndex]{
            case "-h":
                result.append(.help)
            case "-v":
                result.append(.version)
            case "-o":
                guard argumentIndex + 1 < arguments.count else {
                    throw AppIconResizerError.invalidArgument("Argument -o expects a directory. Example '-o someDir'")
                }
                argumentIndex += 1
                result.append(.outputDirectory(directory: arguments[argumentIndex]))
            default:
                // assume a filename was passed
                result.append(.inputFileName(fileName: arguments[argumentIndex]))
            }
            argumentIndex += 1
        }
        return result
    }
}

struct ResizerCLI {
    let commandLineArguments: [String]
 
    var inputFile = ""
    var outputDirectory = "./"

    private mutating func processArgument(_ argument: CommandArgument) {
        switch argument {
        case .help:
            print("AppIcon Resizer - simple command line tool to resize files for iOS icons in all the various sizes.")
            print("Please provide a square input file.")
            print("Note: provide a large input file for best results.")
            print("Usage: appiconresizer <inputfilename> [options]")
            print("Options:")
            print("-h               :  print this help")
            print("-v               :  print version data")
            print("-o <directory>   :  place output files in provided directory.")
        case .version:
            print("AppIcon Resizer version \(version)")
        case .outputDirectory(let directory):
            outputDirectory = directory
            print("Setting \(directory) as output directory.")
        case .inputFileName(let fileName):
            inputFile = fileName
            print("Using file \(inputFile).")
        }
    }

    mutating func execute() {
        do {
            let arguments = try CommandArgument.parseArguments(commandLineArguments)
            
            if arguments.count < 1 {
                //processArgument(CommandArgument.help)
                throw AppIconResizerError.invalidArgument("You need to at least provide a filename 'appiconresizer /path/to/file.png'.")
            }
            
            arguments.forEach { argument in processArgument(argument) }
            try processImages()
        } catch {
            print(error)
        }
    }

    private func processImages() throws {
        if inputFile == "" {
            return
        }
        
        guard let dataProvider = CGDataProvider(filename: inputFile) else {
            throw AppIconResizerError.loadFailure("Could not load data")
        }

        guard let image = CGImage(pngDataProviderSource: dataProvider, decode: nil, shouldInterpolate: false, intent: .defaultIntent) else {
            throw AppIconResizerError.notAnImage("Loaded from file \(inputFile) is not a PNG image.")
        }
        
        if image.width < Resizer.MINIMUM_SOURCE_IMAGE_WIDTH {
            print("The input image should be at least \(Resizer.MINIMUM_SOURCE_IMAGE_WIDTH) pixels wide. Input file is only \(image.width) pixels wide.")
            return
        }
        
        if image.height < Resizer.MINIMUM_SOURCE_IMAGE_HEIGHT {
            print("The input image should be at least \(Resizer.MINIMUM_SOURCE_IMAGE_HEIGHT) pixels wide. Input file is only \(image.height) pixels wide.")
            return
        }

        let scaledImages = Resizer.resizeImage(image)

        let imageName = URL(fileURLWithPath: URL(fileURLWithPath: inputFile).lastPathComponent).deletingPathExtension().lastPathComponent
        print("Setting base image name: \(imageName)")

        let directory = URL(fileURLWithPath: outputDirectory, isDirectory: true)

        try scaledImages.forEach { image in
            
            let url = directory.appendingPathComponent("\(imageName)_\(image.width)x\(image.height).png")
                
            guard let destination = CGImageDestinationCreateWithURL(url as CFURL, kUTTypePNG, 1, nil) else {
                throw AppIconResizerError.couldNotWriteImage("could not create destination file \(url)")
            }
            
            print("Saving to: \(url)")
            
            CGImageDestinationAddImage(destination, image, nil)
            CGImageDestinationFinalize(destination)
        }
    }
}

// the program starts execution here:
var resizerCLI = ResizerCLI(commandLineArguments: CommandLine.arguments)
resizerCLI.execute()
