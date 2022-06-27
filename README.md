# ba9chich
 
pod 'Cosmos'
pod 'TinyConstraints'
pod 'AlamofireImage', '~> 4.1'
pod 'MOLH'
pod 'AppCenter'
pod 'CometChatPro', '2.4.1'
pod 'CometChatCalls', '2.1.1'

route.delete("/deleteTransaction/:expenseId", transaction.delete);


// Delete a note with the specified noteId in the request
exports.delete = (req, res) => {
  TransactionModel.findByIdAndRemove(req.params.expenseId)
    .then((note) => {
      if (!note) {
        return res.status(404).send({
          message: "Note not found with id " + req.params.expenseId,
        });
      }
      res.send({ message: "Note deleted successfully!" });
    })
    .catch((err) => {
      if (err.kind === "ObjectId" || err.name === "NotFound") {
        return res.status(404).send({
          message: "Note not found with id " + req.params.expenseId,
        });
      }
      return res.status(500).send({
        message: "Could not delete note with id " + req.params.expenseId,
      });
    });
};
