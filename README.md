# Networking in Swift with Completion Handlers

## URL Session
1- ```URLSession.shared.datatask ``` create a task that retrives the contents of a url request and then excutes a call back upon completion.
2- Completion handlers are a call back from the API that begins whenever the call request concludes.
3- This code excutes asyncrounusly or non-sequentionly as we don't know the excution time of the API request, and therefor must be excuted on a `background thread`.
4- Data returns as JSON (JavaScript Object Notation) is a lightweight, text-based format for storing and exchanging data. 
It uses key-value pairs and is easy for humans to read and machines to parse.

Once we recived the data we have 2 options to decode the JSON object 
1. **`JSONSerializer`**: This is a general term that usually refers to the process of converting objects to and from JSON. In Swift, this is often done using `JSONSerialization`, which provides methods for converting JSON data into Swift objects and vice versa. It’s a more manual process and requires you to handle the JSON data as `Any` or `Dictionary` types. In summary, `JSONSerialization` is more manual

2. **`JSONDecoder().decode`**: This is a method provided by Swift’s `JSONDecoder` class that allows for the automatic decoding of JSON data into strongly-typed Swift objects. It uses Swift’s `Codable` protocol, which makes it easier to map JSON data directly to your custom data structures with type safety and less manual parsing code. In summary, `JSONDecoder().decode` is more streamlined and type-safe.

## Threading
Updating the user interface must happen on the main thread as it's the `Main path of excution` and gets the most computing power for the app to run smothly. Not only *API Calls* but also *complex operation*, and *heavy calculations* must excute on a background thread to maintain smooth user experiance.

## @escaping 
The escaping keyward endecates that the we need the property which we are calling this completion handler on to escape this block of code. 
Mainly used to mark a closure (a block of code that can be passed around and executed later) that is allowed to outlive the scope in which it was created.

## The Result Type

The `Result` type in Swift is a powerful and flexible way to handle operations that can either succeed with a value or fail with an error. 

#### Definition

The `Result` type is an enum with two cases:

1. **`success`**: Represents a successful operation and holds an associated value of the result type.
2. **`failure`**: Represents a failed operation and holds an associated error value.

#### Syntax

```swift
enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}
```

- `Success`: The type of the value that is returned if the operation succeeds.
- `Failure`: The type of the error that is returned if the operation fails. It must conform to the `Error` protocol.
- 
#### Key Points

- **Type Safety**: The `Result` type enforces type safety by requiring explicit handling of both success and failure cases.
- **Clarity**: It makes the code clearer by showing that the function can return either a success or failure case, and handling these cases becomes more straightforward.
- **Error Handling**: The `failure` case provides a way to carry an error object that conforms to the `Error` protocol, allowing for detailed error reporting and handling.

## The do-try-catch model

In Swift, `try`, `do`, and `catch` are used to handle errors in a controlled manner when working with functions that throw errors. 

- **`try`**: Indicates that a function or method can throw an error and you need to handle it.
- **`do`**: Starts a block of code where you can call throwing functions. Can be followed by *one or more* catch statments.
- **`catch`**: Handles errors thrown within the `do` block and provides ways to handle different error types.

## Retain Cycles

When you create a reference to an object in another object, in swift, this automatically be defaults results in strong reference.
Strong references mean that the 2 objects will keep eachother alive in memory even when one is destroyed. 
This leads to memory leaks, waisted memory, unexpected behaviour and poor preformance.
Therefore, we must use `weak` or `unowned` references to break the cycle and allow proper deallocation of objects.


